resource "google_service_account" "api" {
  account_id   = "${var.application_name}-${substr(var.environment, 0, 4)}-api"
  display_name = "${local.name} API"
  project      = var.project_id
}

resource "google_service_account" "migration" {
  account_id   = "${var.application_name}-${substr(var.environment, 0, 4)}-migrate"
  display_name = "${local.name} migrations"
  project      = var.project_id
}

resource "google_secret_manager_secret_iam_member" "api" {
  project   = var.project_id
  secret_id = google_secret_manager_secret.database_password.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.api.email}"
}

resource "google_secret_manager_secret_iam_member" "migration" {
  project   = var.project_id
  secret_id = google_secret_manager_secret.database_password.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.migration.email}"
}

resource "google_storage_bucket_iam_member" "api_assets" {
  bucket = google_storage_bucket.application.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.api.email}"
}
