resource "google_artifact_registry_repository" "api" {
  format        = "DOCKER"
  location      = var.region
  project       = var.project_id
  repository_id = "${local.name}-api"
  description   = "API container images"
  labels        = local.labels

  docker_config {
    immutable_tags = true
  }

  cleanup_policies {
    id     = "delete-untagged"
    action = "DELETE"

    condition {
      tag_state  = "UNTAGGED"
      older_than = "1209600s"
    }
  }

  depends_on = [google_project_service.required]
}

resource "google_artifact_registry_repository" "migration" {
  format        = "DOCKER"
  location      = var.region
  project       = var.project_id
  repository_id = "${local.name}-migration"
  description   = "Database migration container images"
  labels        = local.labels

  docker_config {
    immutable_tags = true
  }

  cleanup_policies {
    id     = "delete-untagged"
    action = "DELETE"

    condition {
      tag_state  = "UNTAGGED"
      older_than = "1209600s"
    }
  }

  depends_on = [google_project_service.required]
}
