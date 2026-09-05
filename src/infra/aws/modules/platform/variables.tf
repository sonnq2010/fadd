variable "application_name" {
  description = "Short application identifier used in resource names"
  type        = string
  default     = "fadd"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,20}$", var.application_name))
    error_message = "application_name must be 2-21 lowercase letters, numbers, or hyphens."
  }
}

variable "assign_public_ip" {
  description = "Whether ECS tasks receive public IPs for outbound access"
  type        = bool
}

variable "availability_zones" {
  description = "Two availability zones; defaults to the first two available zones"
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.availability_zones) == 0 || length(var.availability_zones) == 2
    error_message = "availability_zones must be empty or contain exactly two zones."
  }
}

variable "api_cpu" {
  description = "Fargate CPU units for the API task"
  type        = number
  default     = 256
}

variable "api_desired_count" {
  description = "Desired number of API tasks"
  type        = number
}

variable "api_image" {
  description = "API container image; production must use an image digest"
  type        = string
  default     = ""
}

variable "api_max_count" {
  description = "Maximum number of API tasks"
  type        = number
  default     = 4
}

variable "api_memory" {
  description = "Fargate memory in MiB for the API task"
  type        = number
  default     = 512
}

variable "backup_retention_days" {
  description = "RDS automated backup retention in days"
  type        = number
}

variable "cloudfront_certificate_arn" {
  description = "Optional ACM certificate ARN in us-east-1 for the custom CloudFront domain"
  type        = string
  default     = null
  nullable    = true
}

variable "common_tags" {
  description = "Additional tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "database_credential_version" {
  description = "Version shared by the RDS password update and password secret payload"
  type        = number
  default     = 1

  validation {
    condition     = var.database_credential_version >= 1 && floor(var.database_credential_version) == var.database_credential_version
    error_message = "database_credential_version must be a positive integer."
  }
}

variable "database_deletion_protection" {
  description = "Whether RDS deletion protection is enabled"
  type        = bool
}

variable "database_instance_class" {
  description = "RDS PostgreSQL instance class"
  type        = string
}

variable "database_multi_az" {
  description = "Whether RDS uses a standby in another availability zone"
  type        = bool
}

variable "database_name" {
  description = "Initial PostgreSQL database name"
  type        = string
  default     = "fadd"
}

variable "database_storage_gib" {
  description = "Allocated RDS storage in GiB"
  type        = number
  default     = 20
}

variable "database_user_password" {
  description = "Password for the RDS database user"
  type        = string
  sensitive   = true
  ephemeral   = true

  validation {
    condition     = length(var.database_user_password) >= 16
    error_message = "database_user_password must contain at least 16 characters."
  }
}

variable "database_username" {
  description = "RDS database username used by the API and migration task"
  type        = string
  default     = "fadd_admin"
}

variable "domain_name" {
  description = "Optional custom frontend domain"
  type        = string
  default     = null
  nullable    = true
}

variable "enable_nat_gateway" {
  description = "Whether to create one NAT Gateway per application subnet"
  type        = bool
}

variable "enable_workloads" {
  description = "Whether to create runtime and migration task definitions and the ECS service"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Deployment environment"
  type        = string

  validation {
    condition     = contains(["staging", "production"], var.environment)
    error_message = "environment must be staging or production."
  }
}

variable "expected_account_id" {
  description = "AWS account ID expected for this environment"
  type        = string

  validation {
    condition     = can(regex("^[0-9]{12}$", var.expected_account_id))
    error_message = "expected_account_id must contain 12 digits."
  }
}

variable "force_destroy_buckets" {
  description = "Whether application buckets may be destroyed while non-empty"
  type        = bool
  default     = false
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
}

variable "migration_image" {
  description = "Migration container image; production must use an image digest"
  type        = string
  default     = ""
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "storage_versioning" {
  description = "Whether application and web buckets have versioning enabled"
  type        = bool
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.20.0.0/16"
}
