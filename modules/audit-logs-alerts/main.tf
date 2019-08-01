resource "google_monitoring_notification_channel" "notification_channel_email" {
  display_name = "Email Notification Channel"
  type = "email"
  labels = {
    email_address = var.notification_email_address
  }
}

resource "google_logging_metric" "metric_iam_owner_change" {
  name = "iam/owner_change"

  filter = <<EOF
  (protoPayload.serviceName = "cloudresourcemanager.googleapis.com") AND
  (ProjectOwnership OR projectOwnerInvitee) OR
  (protoPayload.serviceData.policyDelta.bindingDeltas.action = "REMOVE" AND
   protoPayload.serviceData.policyDelta.bindingDeltas.role   = "roles/owner") OR
  (protoPayload.serviceData.policyDelta.bindingDeltas.action = "ADD" AND
   protoPayload.serviceData.policyDelta.bindingDeltas.role   = "roles/owner")
  EOF

  metric_descriptor {
    value_type = "INT64"
    metric_kind = "DELTA"
  }
}

resource "google_monitoring_alert_policy" "alert_policy_iam_owner_change" {
  display_name = "IAM Owner Change"
  combiner = "OR"
  conditions {
    display_name = "logging/user/iam/owner_change"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/iam/owner_change\" AND resource.type=\"global\""
      duration = "0s"
      comparison = "COMPARISON_GT"

      trigger {
        count = 1
      }
    }
  }

  notification_channels = [
    "${google_monitoring_notification_channel.notification_channel_email.name}",
  ]
}