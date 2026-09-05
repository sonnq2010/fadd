resource "google_monitoring_alert_policy" "cloud_sql_cpu" {
  display_name = "${local.name} Cloud SQL CPU"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "Cloud SQL CPU above 80%"

    condition_threshold {
      comparison      = "COMPARISON_GT"
      duration        = "300s"
      filter          = "resource.type = \"cloudsql_database\" AND metric.type = \"cloudsql.googleapis.com/database/cpu/utilization\""
      threshold_value = 0.8

      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  alert_strategy {
    auto_close = "1800s"
  }

  documentation {
    content   = "Investigate Cloud SQL CPU saturation and API scaling."
    mime_type = "text/markdown"
  }

  user_labels = local.labels

  depends_on = [google_project_service.required]
}
