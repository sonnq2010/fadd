module "platform" {
  source = "../../modules/platform"

  application_name             = var.application_name
  api_cpu                      = "1"
  api_image                    = var.api_image
  api_max_instances            = 2
  api_memory                   = "512Mi"
  api_min_instances            = 0
  backup_retention_count       = 1
  database_availability_type   = "ZONAL"
  database_deletion_protection = false
  database_pitr_enabled        = false
  database_user_password       = var.database_user_password
  database_credential_version  = var.database_credential_version
  database_tier                = "db-f1-micro"
  domain_name                  = var.domain_name
  enable_workloads             = var.enable_workloads
  environment                  = "staging"
  force_destroy_buckets        = false
  migration_image              = var.migration_image
  project_id                   = var.project_id
  region                       = var.region
  storage_versioning           = false
}
