output "api_endpoint" {
  description = "Same-origin API base URL"
  value       = module.platform.api_endpoint
}

output "application_asset_bucket" {
  description = "Private application asset bucket"
  value       = module.platform.application_asset_bucket
}

output "application_endpoint" {
  description = "Public frontend URL"
  value       = module.platform.application_endpoint
}

output "api_repository_url" {
  description = "API Artifact Registry repository URL"
  value       = module.platform.api_repository_url
}

output "database_instance_name" {
  description = "Cloud SQL instance name"
  value       = module.platform.database_instance_name
}

output "database_name" {
  description = "Application PostgreSQL database name"
  value       = module.platform.database_name
}

output "database_private_ip" {
  description = "Private Cloud SQL IP address"
  value       = module.platform.database_private_ip
  sensitive   = true
}

output "database_password_secret_id" {
  description = "Secret to populate with POSTGRES_PASSWORD"
  value       = module.platform.database_password_secret_id
}

output "database_username" {
  description = "Application PostgreSQL username"
  value       = module.platform.database_username
}

output "frontend_ip" {
  description = "Global frontend IP for DNS"
  value       = module.platform.frontend_ip
}

output "migration_job_name" {
  description = "One-off Cloud Run migration job name"
  value       = module.platform.migration_job_name
}

output "migration_repository_url" {
  description = "Migration Artifact Registry repository URL"
  value       = module.platform.migration_repository_url
}

output "static_web_bucket" {
  description = "Static web asset bucket"
  value       = module.platform.static_web_bucket
}
