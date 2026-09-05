resource "google_compute_backend_bucket" "web" {
  name        = "${local.name}-web"
  bucket_name = google_storage_bucket.web.name
  enable_cdn  = true
  project     = var.project_id

  cdn_policy {
    cache_mode        = "CACHE_ALL_STATIC"
    client_ttl        = 3600
    default_ttl       = 3600
    max_ttl           = 31536000
    negative_caching  = true
    serve_while_stale = 86400
  }
}

resource "google_compute_region_network_endpoint_group" "api" {
  count = var.enable_workloads ? 1 : 0

  name                  = "${local.name}-api"
  network_endpoint_type = "SERVERLESS"
  project               = var.project_id
  region                = var.region

  cloud_run {
    service = google_cloud_run_v2_service.api[0].name
  }
}

resource "google_compute_backend_service" "api" {
  count = var.enable_workloads ? 1 : 0

  name                  = "${local.name}-api"
  project               = var.project_id
  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 30

  backend {
    group = google_compute_region_network_endpoint_group.api[0].id
  }
}

resource "google_compute_url_map" "main" {
  name            = "${local.name}-routes"
  project         = var.project_id
  default_service = google_compute_backend_bucket.web.id

  host_rule {
    hosts        = [var.domain_name == null ? "*" : var.domain_name]
    path_matcher = "application"
  }

  path_matcher {
    name            = "application"
    default_service = google_compute_backend_bucket.web.id

    default_custom_error_response_policy {
      error_response_rule {
        match_response_codes   = ["404"]
        path                   = "/_shell.html"
        override_response_code = 200
      }
      error_service = google_compute_backend_bucket.web.id
    }

    dynamic "path_rule" {
      for_each = var.enable_workloads ? [1] : []
      content {
        paths   = ["/api", "/api/*"]
        service = google_compute_backend_service.api[0].id

        custom_error_response_policy {
          error_response_rule {
            match_response_codes   = ["599"]
            path                   = "/_shell.html"
            override_response_code = 599
          }
          error_service = google_compute_backend_bucket.web.id
        }
      }
    }
  }
}

resource "google_compute_global_address" "frontend" {
  name    = "${local.name}-frontend"
  project = var.project_id
}

resource "google_compute_url_map" "https_redirect" {
  count = var.domain_name == null ? 0 : 1

  name    = "${local.name}-https-redirect"
  project = var.project_id

  default_url_redirect {
    https_redirect = true
    strip_query    = false
  }
}

resource "google_compute_target_http_proxy" "frontend" {
  name    = "${local.name}-http"
  project = var.project_id
  url_map = var.domain_name == null ? google_compute_url_map.main.id : google_compute_url_map.https_redirect[0].id
}

resource "google_compute_global_forwarding_rule" "http" {
  name                  = "${local.name}-http"
  ip_address            = google_compute_global_address.frontend.id
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  project               = var.project_id
  target                = google_compute_target_http_proxy.frontend.id
}

resource "google_compute_managed_ssl_certificate" "frontend" {
  count = var.domain_name == null ? 0 : 1

  name    = "${local.name}-certificate"
  project = var.project_id

  managed {
    domains = [var.domain_name]
  }
}

resource "google_compute_target_https_proxy" "frontend" {
  count = var.domain_name == null ? 0 : 1

  name             = "${local.name}-https"
  project          = var.project_id
  url_map          = google_compute_url_map.main.id
  ssl_certificates = [google_compute_managed_ssl_certificate.frontend[0].id]
}

resource "google_compute_global_forwarding_rule" "https" {
  count = var.domain_name == null ? 0 : 1

  name                  = "${local.name}-https"
  ip_address            = google_compute_global_address.frontend.id
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "443"
  project               = var.project_id
  target                = google_compute_target_https_proxy.frontend[0].id
}
