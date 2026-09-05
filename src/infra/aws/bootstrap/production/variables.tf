variable "application_name" {
  description = "Application identifier"
  type        = string
  default     = "fadd"
}

variable "environment" {
  description = "Bootstrap environment"
  type        = string
  default     = "production"
}

variable "expected_account_id" {
  description = "AWS account ID expected for this environment"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "state_bucket_name" {
  description = "Globally unique S3 state bucket name"
  type        = string
}
