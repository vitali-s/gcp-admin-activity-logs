resource "google_logging_metric" "custom_metric" {
  name = var.name

  filter = var.filter

  metric_descriptor {
    value_type = "INT64"
    metric_kind = "DELTA"
  }

  # Sleep for 3 seconds untill custom metric will be created
  provisioner "local-exec" {
    command = "sleep 3"
  }
}

resource "google_monitoring_alert_policy" "custom_alert_policy" {
  display_name = var.policy_display_name
  combiner = "OR"
  conditions {
    display_name = "logging/user/${google_logging_metric.custom_metric.name}"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.custom_metric.name}\" AND resource.type=\"global\""
      duration = "0s"
      comparison = "COMPARISON_GT"
      threshold_value = 0.001

      trigger {
        count = 1
      }
    }
  }

  notification_channels = [
    var.notification_channel_name,
  ]

  enabled = true

  depends_on = [
    google_logging_metric.custom_metric
  ]
}
