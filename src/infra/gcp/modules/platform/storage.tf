resource "google_storage_bucket" "application" {
  name                        = "${var.project_id}-${local.name}-assets"
  location                    = upper(var.region)
  project                     = var.project_id
  force_destroy               = var.force_destroy_buckets
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true
  labels                      = local.labels

  versioning {
    enabled = var.storage_versioning
  }
}

#trivy:ignore:AVD-GCP-0001 This bucket contains only compiled public web assets behind Cloud CDN.
resource "google_storage_bucket" "web" {
  name                        = "${var.project_id}-${local.name}-web"
  location                    = upper(var.region)
  project                     = var.project_id
  force_destroy               = var.force_destroy_buckets
  uniform_bucket_level_access = true
  labels                      = local.labels

  versioning {
    enabled = var.storage_versioning
  }

  website {
    main_page_suffix = "_shell.html"
    not_found_page   = "_shell.html"
  }
}

#trivy:ignore:AVD-GCP-0001 This IAM grant exposes only compiled public web assets through Cloud CDN.
resource "google_storage_bucket_iam_member" "web_public" {
  bucket = google_storage_bucket.web.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
