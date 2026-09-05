locals {
  postgres_environment = [
    { name = "POSTGRES_DB", value = var.database_name },
    { name = "POSTGRES_HOST", value = aws_db_instance.main.address },
    { name = "POSTGRES_PORT", value = tostring(aws_db_instance.main.port) },
    { name = "POSTGRES_SSLMODE", value = "require" },
    { name = "POSTGRES_USER", value = var.database_username },
  ]
  postgres_secrets = [{
    name      = "POSTGRES_PASSWORD"
    valueFrom = aws_secretsmanager_secret.database_password.arn
  }]
}

resource "random_password" "origin_header" {
  length  = 32
  special = false
}

resource "aws_cloudwatch_log_group" "api" {
  name              = "/fadd/${local.name}/api"
  retention_in_days = var.log_retention_days
  tags              = local.tags
}

resource "aws_cloudwatch_log_group" "migration" {
  name              = "/fadd/${local.name}/migration"
  retention_in_days = var.log_retention_days
  tags              = local.tags
}

resource "aws_ecs_cluster" "main" {
  name = local.name

  setting {
    name  = "containerInsights"
    value = var.environment == "production" ? "enabled" : "disabled"
  }

  tags = local.tags
}

#trivy:ignore:AVD-AWS-0053 The public ALB only accepts the CloudFront managed origin prefix list.
#trivy:ignore:AVD-AWS-0054 Viewer traffic is HTTPS; the restricted CloudFront origin uses HTTP to the ALB.
resource "aws_lb" "api" {
  name                       = substr("${local.name}-api", 0, 32)
  drop_invalid_header_fields = true
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.load_balancer.id]
  subnets                    = values(aws_subnet.public)[*].id
  tags                       = local.tags
}

resource "aws_lb_target_group" "api" {
  name        = substr("${local.name}-api", 0, 32)
  port        = 8888
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/api/v1/health"
    timeout             = 5
    unhealthy_threshold = 3
  }

  tags = local.tags
}

#trivy:ignore:AVD-AWS-0054 Viewer traffic is HTTPS; the CloudFront-only origin listener uses HTTP.
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.api.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Forbidden"
      status_code  = "403"
    }
  }
}

resource "aws_lb_listener_rule" "cloudfront" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }

  condition {
    http_header {
      http_header_name = "X-Origin-Verify"
      values           = [random_password.origin_header.result]
    }
  }
}

resource "aws_ecs_task_definition" "api" {
  count = var.enable_workloads ? 1 : 0

  family                   = "${local.name}-api"
  cpu                      = tostring(var.api_cpu)
  execution_role_arn       = aws_iam_role.execution.arn
  memory                   = tostring(var.api_memory)
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.runtime.arn

  container_definitions = jsonencode([{
    name      = "api"
    image     = var.api_image
    essential = true
    portMappings = [{
      containerPort = 8888
      hostPort      = 8888
      protocol      = "tcp"
    }]
    environment = concat([{ name = "PORT", value = "8888" }], local.postgres_environment)
    secrets     = local.postgres_secrets
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = aws_cloudwatch_log_group.api.name
        awslogs-region        = var.region
        awslogs-stream-prefix = "api"
      }
    }
  }])

  tags = local.tags
}

resource "aws_ecs_task_definition" "migration" {
  count = var.enable_workloads ? 1 : 0

  family                   = "${local.name}-migration"
  cpu                      = "256"
  execution_role_arn       = aws_iam_role.execution.arn
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.runtime.arn

  container_definitions = jsonencode([{
    name        = "migration"
    image       = var.migration_image
    essential   = true
    environment = local.postgres_environment
    secrets     = local.postgres_secrets
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = aws_cloudwatch_log_group.migration.name
        awslogs-region        = var.region
        awslogs-stream-prefix = "migration"
      }
    }
  }])

  tags = local.tags
}

resource "aws_ecs_service" "api" {
  count = var.enable_workloads ? 1 : 0

  name            = "${local.name}-api"
  cluster         = aws_ecs_cluster.main.id
  desired_count   = var.api_desired_count
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.api[0].arn

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  load_balancer {
    container_name   = "api"
    container_port   = 8888
    target_group_arn = aws_lb_target_group.api.arn
  }

  network_configuration {
    assign_public_ip = var.assign_public_ip
    security_groups  = [aws_security_group.api.id]
    subnets          = values(aws_subnet.application)[*].id
  }

  depends_on = [aws_lb_listener_rule.cloudfront]

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = local.tags
}

resource "aws_appautoscaling_target" "api" {
  count = var.enable_workloads ? 1 : 0

  max_capacity       = var.api_max_count
  min_capacity       = var.api_desired_count
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.api[0].name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "api_cpu" {
  count = var.enable_workloads ? 1 : 0

  name               = "${local.name}-cpu"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.api[0].resource_id
  scalable_dimension = aws_appautoscaling_target.api[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.api[0].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 70

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}
