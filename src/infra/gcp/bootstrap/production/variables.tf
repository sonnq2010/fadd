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

variable "project_id" {
  description = "GCP project ID for this environment"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "asia-northeast1"
}

variable "state_bucket_name" {
  description = "Globally unique GCS state bucket name"
  type        = string
}
