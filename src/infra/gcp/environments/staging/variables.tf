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

variable "database_user_password" {
  description = "Password for the built-in application database user"
  type        = string
  sensitive   = true
  ephemeral   = true
}

variable "database_credential_version" {
  description = "Version shared by the Cloud SQL password update and Secret Manager password payload"
  type        = number
  default     = 1
}

variable "domain_name" {
  description = "Optional frontend domain"
  type        = string
  default     = null
  nullable    = true
}

variable "enable_workloads" {
  description = "Create Cloud Run service and migration job"
  type        = bool
  default     = false
}

variable "migration_image" {
  description = "Migration image URI"
  type        = string
  default     = ""
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
