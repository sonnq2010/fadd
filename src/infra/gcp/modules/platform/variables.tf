variable "application_name" {
  description = "Short application identifier used in resource names"
  type        = string
  default     = "fadd"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,20}$", var.application_name))
    error_message = "application_name must be 2-21 lowercase letters, numbers, or hyphens."
  }
}

variable "api_cpu" {
  description = "Cloud Run CPU limit"
  type        = string
  default     = "1"
}

variable "api_image" {
  description = "API container image; production must use an image digest"
  type        = string
  default     = ""
}

variable "api_max_instances" {
  description = "Maximum Cloud Run API instances"
  type        = number
  default     = 4
}

variable "api_memory" {
  description = "Cloud Run memory limit"
  type        = string
  default     = "512Mi"
}

variable "api_min_instances" {
  description = "Minimum Cloud Run API instances"
  type        = number
}

variable "backup_retention_count" {
  description = "Number of retained Cloud SQL backups"
  type        = number
}

variable "common_labels" {
  description = "Additional labels applied to resources"
  type        = map(string)
  default     = {}
}

variable "database_availability_type" {
  description = "Cloud SQL availability type: ZONAL or REGIONAL"
  type        = string

  validation {
    condition     = contains(["ZONAL", "REGIONAL"], var.database_availability_type)
    error_message = "database_availability_type must be ZONAL or REGIONAL."
  }
}

variable "database_deletion_protection" {
  description = "Whether Cloud SQL deletion protection is enabled"
  type        = bool
}

variable "database_name" {
  description = "Initial PostgreSQL database name"
  type        = string
  default     = "fadd"
}

variable "database_pitr_enabled" {
  description = "Whether point-in-time recovery is enabled"
  type        = bool
}

variable "database_tier" {
  description = "Cloud SQL machine tier"
  type        = string
}

variable "database_user_password" {
  description = "Password for the built-in application database user"
  type        = string
  sensitive   = true
  ephemeral   = true

  validation {
    condition     = length(var.database_user_password) >= 16
    error_message = "database_user_password must contain at least 16 characters."
  }
}

variable "database_credential_version" {
  description = "Version shared by the Cloud SQL password update and Secret Manager password payload"
  type        = number
  default     = 1

  validation {
    condition     = var.database_credential_version >= 1 && floor(var.database_credential_version) == var.database_credential_version
    error_message = "database_credential_version must be a positive integer."
  }
}

variable "database_username" {
  description = "Built-in PostgreSQL user used by the application and migration job"
  type        = string
  default     = "fadd_app"

  validation {
    condition     = can(regex("^[a-z_][a-z0-9_]{0,62}$", var.database_username))
    error_message = "database_username must be a valid lowercase PostgreSQL identifier."
  }
}

variable "domain_name" {
  description = "Optional custom frontend domain for managed TLS"
  type        = string
  default     = null
  nullable    = true
}

variable "enable_workloads" {
  description = "Whether to create Cloud Run service, job, and load-balancer API service"
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

variable "force_destroy_buckets" {
  description = "Whether application buckets may be destroyed while non-empty"
  type        = bool
  default     = false
}

variable "migration_image" {
  description = "Migration container image; production must use an image digest"
  type        = string
  default     = ""
}

variable "project_id" {
  description = "GCP project ID expected for this environment"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "asia-northeast1"
}

variable "storage_versioning" {
  description = "Whether application and web buckets have versioning enabled"
  type        = bool
}

variable "subnet_cidr" {
  description = "CIDR block for direct Cloud Run VPC egress"
  type        = string
  default     = "10.30.0.0/24"
}
