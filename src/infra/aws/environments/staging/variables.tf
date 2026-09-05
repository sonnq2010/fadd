variable "application_name" {
  description = "Application identifier"
  type        = string
  default     = "fadd"
}

variable "api_image" {
  description = "API image URI"
  type        = string
  default     = ""
}

variable "cloudfront_certificate_arn" {
  description = "Optional ACM certificate ARN in us-east-1 for the frontend domain"
  type        = string
  default     = null
  nullable    = true
}

variable "database_credential_version" {
  description = "Version shared by the RDS password update and password secret payload"
  type        = number
  default     = 1
}

variable "database_user_password" {
  description = "Password for the RDS database user"
  type        = string
  sensitive   = true
  ephemeral   = true
}

variable "domain_name" {
  description = "Optional frontend domain"
  type        = string
  default     = null
  nullable    = true
}

variable "enable_workloads" {
  description = "Create ECS task definitions and service"
  type        = bool
  default     = false
}

variable "expected_account_id" {
  description = "AWS account ID expected for this environment"
  type        = string
}

variable "migration_image" {
  description = "Migration image URI"
  type        = string
  default     = ""
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}
