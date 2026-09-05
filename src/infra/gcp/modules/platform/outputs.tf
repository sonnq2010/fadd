output "api_endpoint" {
  description = "Same-origin API base URL"
  value       = "${var.domain_name == null ? "http" : "https"}://${var.domain_name == null ? google_compute_global_address.frontend.address : var.domain_name}"
}

output "application_asset_bucket" {
  description = "Private application asset bucket"
  value       = google_storage_bucket.application.name
}

output "application_endpoint" {
  description = "Public frontend URL"
  value       = "${var.domain_name == null ? "http" : "https"}://${var.domain_name == null ? google_compute_global_address.frontend.address : var.domain_name}"
}

output "api_repository_url" {
  description = "API Artifact Registry repository URL"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.api.repository_id}"
}

output "database_instance_name" {
  description = "Cloud SQL instance name"
  value       = google_sql_database_instance.main.name
}

output "database_name" {
  description = "Application PostgreSQL database name"
  value       = google_sql_database.application.name
}

output "database_private_ip" {
  description = "Private Cloud SQL IP address"
  value       = google_sql_database_instance.main.private_ip_address
  sensitive   = true
}

output "database_password_secret_id" {
  description = "Secret Manager secret to populate with POSTGRES_PASSWORD"
  value       = google_secret_manager_secret.database_password.id
}

output "database_username" {
  description = "Application PostgreSQL username"
  value       = google_sql_user.application.name
}

output "frontend_ip" {
  description = "Global frontend IP for DNS"
  value       = google_compute_global_address.frontend.address
}

output "migration_job_name" {
  description = "One-off Cloud Run migration job name"
  value       = var.enable_workloads ? google_cloud_run_v2_job.migration[0].name : null
}

output "migration_repository_url" {
  description = "Migration Artifact Registry repository URL"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.migration.repository_id}"
}

output "static_web_bucket" {
  description = "Static web asset bucket"
  value       = google_storage_bucket.web.name
}
