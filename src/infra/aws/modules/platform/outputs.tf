output "api_endpoint" {
  description = "Same-origin API base URL"
  value       = "https://${var.domain_name == null ? aws_cloudfront_distribution.main.domain_name : var.domain_name}"
}

output "api_service_name" {
  description = "ECS service running the API"
  value       = var.enable_workloads ? aws_ecs_service.api[0].name : null
}

output "application_asset_bucket" {
  description = "Private application asset bucket"
  value       = aws_s3_bucket.application.id
}

output "application_endpoint" {
  description = "Public frontend URL"
  value       = "https://${var.domain_name == null ? aws_cloudfront_distribution.main.domain_name : var.domain_name}"
}

output "api_repository_url" {
  description = "API ECR repository URL"
  value       = aws_ecr_repository.api.repository_url
}

output "database_endpoint" {
  description = "Private RDS endpoint"
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}


output "migration_repository_url" {
  description = "Migration ECR repository URL"
  value       = aws_ecr_repository.migration.repository_url
}

output "migration_task_definition_arn" {
  description = "One-off migration task definition ARN"
  value       = var.enable_workloads ? aws_ecs_task_definition.migration[0].arn : null
}

output "static_web_bucket" {
  description = "Static web asset bucket"
  value       = aws_s3_bucket.web.id
}

output "task_security_group_id" {
  description = "Security group for one-off ECS migration tasks"
  value       = aws_security_group.api.id
}

output "task_subnet_ids" {
  description = "Subnet IDs for one-off ECS migration tasks"
  value       = values(aws_subnet.application)[*].id
}

output "ecs_cluster_name" {
  description = "ECS cluster used by API and migration tasks"
  value       = aws_ecs_cluster.main.name
}

output "database_instance_id" {
  description = "RDS database instance identifier"
  value       = aws_db_instance.main.identifier
}

output "database_password_secret_arn" {
  description = "Secrets Manager secret to populate with POSTGRES_PASSWORD"
  value       = aws_secretsmanager_secret.database_password.arn
}
