mock_provider "google" {}

mock_provider "random" {}

run "staging_is_cost_optimized" {
  command = plan

  variables {
    api_min_instances            = 0
    backup_retention_count       = 1
    database_availability_type   = "ZONAL"
    database_deletion_protection = false
    database_pitr_enabled        = false
    database_tier                = "db-f1-micro"
    database_credential_version  = 7
    database_user_password       = "test-only-password"
    enable_workloads             = false
    environment                  = "staging"
    project_id                   = "fadd-test-project"
    storage_versioning           = false
  }

  assert {
    condition     = google_sql_database_instance.main.settings[0].availability_type == "ZONAL"
    error_message = "Staging Cloud SQL must remain zonal by default."
  }

  assert {
    condition     = google_sql_database_instance.main.settings[0].ip_configuration[0].ipv4_enabled == false
    error_message = "Cloud SQL must not expose a public IPv4 address."
  }
}

run "production_has_ha_and_protection" {
  command = plan

  variables {
    api_image                    = "asia-northeast1-docker.pkg.dev/test/api/app@sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    api_min_instances            = 2
    backup_retention_count       = 14
    database_availability_type   = "REGIONAL"
    database_deletion_protection = true
    database_pitr_enabled        = true
    database_tier                = "db-custom-2-7680"
    database_credential_version  = 7
    database_user_password       = "test-only-password"
    domain_name                  = "app.example.com"
    enable_workloads             = true
    environment                  = "production"
    migration_image              = "asia-northeast1-docker.pkg.dev/test/migration/app@sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    project_id                   = "fadd-test-project"
    storage_versioning           = true
  }

  assert {
    condition     = google_sql_database_instance.main.settings[0].availability_type == "REGIONAL"
    error_message = "Production Cloud SQL must use regional HA."
  }

  assert {
    condition     = google_sql_database_instance.main.deletion_protection
    error_message = "Production Cloud SQL must be deletion protected."
  }

  assert {
    condition     = google_sql_database_instance.main.settings[0].deletion_protection_enabled
    error_message = "Production Cloud SQL must enable GCP API-level deletion protection."
  }

  assert {
    condition     = google_sql_user.application.name == "fadd_app"
    error_message = "The platform must create a dedicated application database user."
  }

  assert {
    condition     = google_cloud_run_v2_service.api[0].template[0].scaling[0].min_instance_count == 2
    error_message = "Production must keep at least two warm API instances."
  }

  assert {
    condition     = google_cloud_run_v2_job.migration[0].template[0].task_count == 1
    error_message = "A one-off migration job must be defined."
  }

  assert {
    condition = toset([
      for item in google_cloud_run_v2_service.api[0].template[0].containers[0].env : item.name
    ]) == toset(["PORT", "POSTGRES_USER", "POSTGRES_PASSWORD", "POSTGRES_DB", "POSTGRES_HOST", "POSTGRES_PORT", "POSTGRES_SSLMODE"])
    error_message = "The API service must use the complete POSTGRES_* contract."
  }

  assert {
    condition = toset([
      for item in google_cloud_run_v2_job.migration[0].template[0].template[0].containers[0].env : item.name
    ]) == toset(["POSTGRES_USER", "POSTGRES_PASSWORD", "POSTGRES_DB", "POSTGRES_HOST", "POSTGRES_PORT", "POSTGRES_SSLMODE"])
    error_message = "The migration job must use the complete POSTGRES_* contract."
  }

  assert {
    condition = one([
      for item in google_cloud_run_v2_service.api[0].template[0].containers[0].env : item.value_source[0].secret_key_ref[0].version
      if item.name == "POSTGRES_PASSWORD"
    ]) == "7"
    error_message = "The API password must pin the configured Secret Manager version."
  }

  assert {
    condition = one([
      for item in google_cloud_run_v2_job.migration[0].template[0].template[0].containers[0].env : item.value_source[0].secret_key_ref[0].version
      if item.name == "POSTGRES_PASSWORD"
    ]) == "7"
    error_message = "The migration password must pin the configured Secret Manager version."
  }

  assert {
    condition     = google_sql_user.application.password_wo_version == 7
    error_message = "Cloud SQL and runtime secrets must use the same credential version."
  }

  assert {
    condition     = toset(google_compute_url_map.main.path_matcher[0].default_custom_error_response_policy[0].error_response_rule[0].match_response_codes) == toset(["404"])
    error_message = "Static routes must fall back to the SPA shell on 404."
  }

  assert {
    condition     = toset(google_compute_url_map.main.path_matcher[0].path_rule[0].custom_error_response_policy[0].error_response_rule[0].match_response_codes) == toset(["599"])
    error_message = "API routes must override the static 404 fallback."
  }
}

run "production_without_domain_is_rejected" {
  command = plan

  variables {
    api_image                    = "asia-northeast1-docker.pkg.dev/test/api/app@sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    api_min_instances            = 2
    backup_retention_count       = 14
    database_availability_type   = "REGIONAL"
    database_deletion_protection = true
    database_pitr_enabled        = true
    database_tier                = "db-custom-2-7680"
    database_credential_version  = 7
    database_user_password       = "test-only-password"
    enable_workloads             = true
    environment                  = "production"
    migration_image              = "asia-northeast1-docker.pkg.dev/test/migration/app@sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    project_id                   = "fadd-test-project"
    storage_versioning           = true
  }

  expect_failures = [check.production_safety]
}

run "unsafe_production_is_rejected" {
  command = plan

  variables {
    api_min_instances            = 0
    backup_retention_count       = 1
    database_availability_type   = "ZONAL"
    database_deletion_protection = false
    database_pitr_enabled        = false
    database_tier                = "db-f1-micro"
    database_credential_version  = 7
    database_user_password       = "test-only-password"
    enable_workloads             = false
    environment                  = "production"
    force_destroy_buckets        = true
    project_id                   = "fadd-test-project"
    storage_versioning           = false
  }

  expect_failures = [check.production_safety]
}
