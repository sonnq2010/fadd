resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.tags, { Name = "${local.name}-vpc" })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = merge(local.tags, { Name = "${local.name}-igw" })
}

resource "aws_subnet" "public" {
  for_each = { for index, az in local.azs : az => index }

  availability_zone       = each.key
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, each.value)
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main.id

  tags = merge(local.tags, { Name = "${local.name}-public-${each.value + 1}" })
}

resource "aws_subnet" "application" {
  for_each = { for index, az in local.azs : az => index }

  availability_zone       = each.key
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, each.value + 4)
  map_public_ip_on_launch = var.assign_public_ip
  vpc_id                  = aws_vpc.main.id

  tags = merge(local.tags, { Name = "${local.name}-app-${each.value + 1}" })
}

resource "aws_subnet" "database" {
  for_each = { for index, az in local.azs : az => index }

  availability_zone = each.key
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, each.value + 8)
  vpc_id            = aws_vpc.main.id

  tags = merge(local.tags, { Name = "${local.name}-db-${each.value + 1}" })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(local.tags, { Name = "${local.name}-public" })
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  route_table_id = aws_route_table.public.id
  subnet_id      = each.value.id
}

resource "aws_eip" "nat" {
  for_each = var.enable_nat_gateway ? aws_subnet.public : {}

  domain = "vpc"
  tags   = merge(local.tags, { Name = "${local.name}-nat-${each.key}" })

  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "main" {
  for_each = var.enable_nat_gateway ? aws_subnet.public : {}

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id
  tags          = merge(local.tags, { Name = "${local.name}-nat-${each.key}" })
}

resource "aws_route_table" "application" {
  for_each = aws_subnet.application

  vpc_id = aws_vpc.main.id

  dynamic "route" {
    for_each = var.enable_nat_gateway ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.main[each.key].id
    }
  }

  dynamic "route" {
    for_each = var.assign_public_ip && !var.enable_nat_gateway ? [1] : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.main.id
    }
  }

  tags = merge(local.tags, { Name = "${local.name}-app-${each.key}" })
}

resource "aws_route_table_association" "application" {
  for_each = aws_subnet.application

  route_table_id = aws_route_table.application[each.key].id
  subnet_id      = each.value.id
}

resource "aws_security_group" "load_balancer" {
  name        = "${local.name}-alb"
  description = "Allow CloudFront origin traffic to the load balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "HTTP from CloudFront origin-facing network"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    prefix_list_ids = [data.aws_ec2_managed_prefix_list.cloudfront.id]
  }

  egress {
    description = "API traffic inside the VPC"
    from_port   = 8888
    to_port     = 8888
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = merge(local.tags, { Name = "${local.name}-alb" })
}

#trivy:ignore:aws-vpc-no-public-egress-sgr API tasks require outbound HTTPS for external identity and API dependencies.
resource "aws_security_group" "api" {
  name        = "${local.name}-api"
  description = "Allow API traffic from the load balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "API HTTP from ALB"
    from_port       = 8888
    to_port         = 8888
    protocol        = "tcp"
    security_groups = [aws_security_group.load_balancer.id]
  }

  egress {
    description = "HTTPS dependencies"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "PostgreSQL inside the VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = merge(local.tags, { Name = "${local.name}-api" })
}

resource "aws_security_group" "database" {
  name        = "${local.name}-database"
  description = "Allow PostgreSQL only from API tasks"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "PostgreSQL from API"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.api.id]
  }

  tags = merge(local.tags, { Name = "${local.name}-database" })
}
