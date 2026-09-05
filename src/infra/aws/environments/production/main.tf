module "platform" {
  source = "../../modules/platform"

  application_name             = var.application_name
  assign_public_ip             = false
  api_cpu                      = 512
  api_desired_count            = 2
  api_image                    = var.api_image
  api_max_count                = 8
  api_memory                   = 1024
  cloudfront_certificate_arn   = var.cloudfront_certificate_arn
  backup_retention_days        = 14
  database_deletion_protection = true
  database_credential_version  = var.database_credential_version
  database_user_password       = var.database_user_password
  database_instance_class      = "db.t4g.small"
  database_multi_az            = true
  domain_name                  = var.domain_name
  enable_nat_gateway           = true
  enable_workloads             = var.enable_workloads
  environment                  = "production"
  expected_account_id          = var.expected_account_id
  force_destroy_buckets        = false
  log_retention_days           = 90
  migration_image              = var.migration_image
  region                       = var.region
  storage_versioning           = true
}
