resource "google_cloud_run_v2_service" "api" {
  count = var.enable_workloads ? 1 : 0

  name                = "${local.name}-api"
  location            = var.region
  project             = var.project_id
  deletion_protection = var.environment == "production"
  ingress             = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"
  labels              = local.labels

  template {
    service_account = google_service_account.api.email

    scaling {
      min_instance_count = var.api_min_instances
      max_instance_count = var.api_max_instances
    }

    vpc_access {
      egress = "PRIVATE_RANGES_ONLY"

      network_interfaces {
        network    = google_compute_network.main.name
        subnetwork = google_compute_subnetwork.serverless.name
      }
    }

    containers {
      image = var.api_image

      ports {
        container_port = 8888
      }

      resources {
        limits = {
          cpu    = var.api_cpu
          memory = var.api_memory
        }
        cpu_idle = true
      }

      env {
        name  = "PORT"
        value = "8888"
      }

      env {
        name  = "POSTGRES_USER"
        value = google_sql_user.application.name
      }

      env {
        name = "POSTGRES_PASSWORD"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.database_password.secret_id
            version = tostring(var.database_credential_version)
          }
        }
      }

      env {
        name  = "POSTGRES_DB"
        value = google_sql_database.application.name
      }

      env {
        name  = "POSTGRES_HOST"
        value = google_sql_database_instance.main.private_ip_address
      }

      env {
        name  = "POSTGRES_PORT"
        value = "5432"
      }

      env {
        name  = "POSTGRES_SSLMODE"
        value = "require"
      }

      startup_probe {
        initial_delay_seconds = 1
        timeout_seconds       = 2
        period_seconds        = 5
        failure_threshold     = 12

        http_get {
          path = "/api/v1/health"
          port = 8888
        }
      }

      liveness_probe {
        timeout_seconds   = 2
        period_seconds    = 30
        failure_threshold = 3

        http_get {
          path = "/api/v1/health"
          port = 8888
        }
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  depends_on = [google_project_service.required, google_secret_manager_secret_iam_member.api]
}

resource "google_cloud_run_v2_service_iam_member" "public_invoker" {
  count = var.enable_workloads ? 1 : 0

  project  = var.project_id
  location = var.region
  name     = google_cloud_run_v2_service.api[0].name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_v2_job" "migration" {
  count = var.enable_workloads ? 1 : 0

  name                = "${local.name}-migration"
  location            = var.region
  project             = var.project_id
  deletion_protection = var.environment == "production"
  labels              = local.labels

  template {
    task_count = 1

    template {
      service_account = google_service_account.migration.email
      timeout         = "900s"
      max_retries     = 1

      vpc_access {
        egress = "PRIVATE_RANGES_ONLY"

        network_interfaces {
          network    = google_compute_network.main.name
          subnetwork = google_compute_subnetwork.serverless.name
        }
      }

      containers {
        image = var.migration_image

        resources {
          limits = {
            cpu    = "1"
            memory = "512Mi"
          }
        }

        env {
          name  = "POSTGRES_USER"
          value = google_sql_user.application.name
        }

        env {
          name = "POSTGRES_PASSWORD"
          value_source {
            secret_key_ref {
              secret  = google_secret_manager_secret.database_password.secret_id
              version = tostring(var.database_credential_version)
            }
          }
        }

        env {
          name  = "POSTGRES_DB"
          value = google_sql_database.application.name
        }

        env {
          name  = "POSTGRES_HOST"
          value = google_sql_database_instance.main.private_ip_address
        }

        env {
          name  = "POSTGRES_PORT"
          value = "5432"
        }

        env {
          name  = "POSTGRES_SSLMODE"
          value = "require"
        }
      }
    }
  }

  depends_on = [google_project_service.required, google_secret_manager_secret_iam_member.migration]
}
