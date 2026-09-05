resource "google_compute_network" "main" {
  name                    = "${local.name}-vpc"
  auto_create_subnetworks = false
  project                 = var.project_id

  depends_on = [google_project_service.required]
}

resource "google_compute_subnetwork" "serverless" {
  name                     = "${local.name}-serverless"
  ip_cidr_range            = var.subnet_cidr
  network                  = google_compute_network.main.id
  private_ip_google_access = true
  project                  = var.project_id
  region                   = var.region
}

resource "google_compute_global_address" "private_services" {
  name          = "${local.name}-private-services"
  address_type  = "INTERNAL"
  prefix_length = 16
  purpose       = "VPC_PEERING"
  network       = google_compute_network.main.id
  project       = var.project_id
}

resource "google_service_networking_connection" "private_services" {
  network                 = google_compute_network.main.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_services.name]

  depends_on = [google_project_service.required]
}
