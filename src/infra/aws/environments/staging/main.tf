module "platform" {
  source = "../../modules/platform"

  application_name             = var.application_name
  assign_public_ip             = true
  api_cpu                      = 256
  api_desired_count            = 1
  api_image                    = var.api_image
  api_max_count                = 2
  api_memory                   = 512
  cloudfront_certificate_arn   = var.cloudfront_certificate_arn
  backup_retention_days        = 1
  database_deletion_protection = false
  database_credential_version  = var.database_credential_version
  database_user_password       = var.database_user_password
  database_instance_class      = "db.t4g.micro"
  database_multi_az            = false
  domain_name                  = var.domain_name
  enable_nat_gateway           = false
  enable_workloads             = var.enable_workloads
  environment                  = "staging"
  expected_account_id          = var.expected_account_id
  force_destroy_buckets        = false
  log_retention_days           = 14
  migration_image              = var.migration_image
  region                       = var.region
  storage_versioning           = false
}
