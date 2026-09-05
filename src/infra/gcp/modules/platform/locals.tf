locals {
  name = "${var.application_name}-${var.environment}"
  labels = merge(var.common_labels, {
    application = var.application_name
    environment = var.environment
    managed-by  = "terraform"
  })

  required_services = toset([
    "artifactregistry.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
    "servicenetworking.googleapis.com",
    "sqladmin.googleapis.com",
    "storage.googleapis.com",
  ])
}
