module "platform" {
  source = "../../modules/platform"

  application_name             = var.application_name
  api_cpu                      = "2"
  api_image                    = var.api_image
  api_max_instances            = 10
  api_memory                   = "1Gi"
  api_min_instances            = 2
  backup_retention_count       = 14
  database_availability_type   = "REGIONAL"
  database_deletion_protection = true
  database_pitr_enabled        = true
  database_user_password       = var.database_user_password
  database_credential_version  = var.database_credential_version
  database_tier                = "db-custom-2-7680"
  domain_name                  = var.domain_name
  enable_workloads             = var.enable_workloads
  environment                  = "production"
  force_destroy_buckets        = false
  migration_image              = var.migration_image
  project_id                   = var.project_id
  region                       = var.region
  storage_versioning           = true
}
