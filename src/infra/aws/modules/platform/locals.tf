data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

data "aws_ec2_managed_prefix_list" "cloudfront" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

locals {
  name = "${var.application_name}-${var.environment}"
  azs  = length(var.availability_zones) == 2 ? var.availability_zones : slice(data.aws_availability_zones.available.names, 0, 2)

  tags = merge(var.common_tags, {
    Application = var.application_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  })
}
