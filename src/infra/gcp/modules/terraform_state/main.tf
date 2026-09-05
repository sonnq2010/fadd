resource "google_storage_bucket" "state" {
  name                        = var.bucket_name
  location                    = var.location
  force_destroy               = false
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true
  labels                      = var.labels

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      num_newer_versions = 20
      with_state         = "ARCHIVED"
    }
    action {
      type = "Delete"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
