resource "random_id" "database" {
  byte_length = 3
}

#trivy:ignore:AVD-GCP-0015 ssl_mode ENCRYPTED_ONLY enforces TLS; Trivy 0.67 does not recognize the current provider field.
resource "google_sql_database_instance" "main" {
  name             = "${local.name}-${random_id.database.hex}"
  project          = var.project_id
  region           = var.region
  database_version = "POSTGRES_17"

  deletion_protection = var.database_deletion_protection

  settings {
    availability_type           = var.database_availability_type
    deletion_protection_enabled = var.database_deletion_protection
    disk_autoresize             = true
    disk_autoresize_limit       = 100
    disk_size                   = 20
    disk_type                   = "PD_SSD"
    tier                        = var.database_tier

    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = var.database_pitr_enabled
      start_time                     = "18:00"
      transaction_log_retention_days = var.database_pitr_enabled ? 7 : 1

      backup_retention_settings {
        retained_backups = var.backup_retention_count
        retention_unit   = "COUNT"
      }
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.main.id
      ssl_mode        = "ENCRYPTED_ONLY"
    }

    maintenance_window {
      day          = 7
      hour         = 19
      update_track = "stable"
    }

    user_labels = local.labels
  }

  depends_on = [google_service_networking_connection.private_services]
}

resource "google_sql_database" "application" {
  name     = var.database_name
  instance = google_sql_database_instance.main.name
  project  = var.project_id
}

resource "google_sql_user" "application" {
  name     = var.database_username
  instance = google_sql_database_instance.main.name
  project  = var.project_id

  password_wo         = var.database_user_password
  password_wo_version = var.database_credential_version
}

resource "google_secret_manager_secret" "database_password" {
  project   = var.project_id
  secret_id = "${local.name}-database-password"
  labels    = local.labels

  replication {
    auto {}
  }

  depends_on = [google_project_service.required]
}
