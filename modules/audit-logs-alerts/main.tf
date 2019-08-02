resource "google_monitoring_notification_channel" "notification_channel_email" {
  display_name = "Email Notification Channel"
  type = "email"
  labels = {
    email_address = var.notification_email_address
  }
}

module "iam-owner-change-alert" {
  source = "../custom-alert-policy"

  name = "iam/owner_change"
  policy_display_name = "IAM Owner Change"
  notification_channel_name = "${google_monitoring_notification_channel.notification_channel_email.name}"

  filter = <<EOF
    (protoPayload.serviceName = "cloudresourcemanager.googleapis.com") AND
    (ProjectOwnership OR projectOwnerInvitee) OR
    (protoPayload.serviceData.policyDelta.bindingDeltas.action = "REMOVE" AND
     protoPayload.serviceData.policyDelta.bindingDeltas.role   = "roles/owner") OR
    (protoPayload.serviceData.policyDelta.bindingDeltas.action = "ADD" AND
     protoPayload.serviceData.policyDelta.bindingDeltas.role   = "roles/owner")
  EOF
}

module "iam-audit-config-change-alert" {
  source = "../custom-alert-policy"

  name = "iam/audit_config_change"
  policy_display_name = "IAM Audit Config Change"
  notification_channel_name = "${google_monitoring_notification_channel.notification_channel_email.name}"

  filter = <<EOF
    protoPayload.methodName="SetIamPolicy" AND
    protoPayload.serviceData.policyDelta.auditConfigDeltas:*
  EOF
}

module "iam-custom-role-change-alert" {
  source = "../custom-alert-policy"

  name = "iam/custom_role_change"
  policy_display_name = "IAM Custom Role Change"
  notification_channel_name = "${google_monitoring_notification_channel.notification_channel_email.name}"

  filter = <<EOF
    resource.type="iam_role" AND
    protoPayload.methodName = "google.iam.admin.v1.CreateRole" OR
    protoPayload.methodName = "google.iam.admin.v1.DeleteRole" OR
    protoPayload.methodName = "google.iam.admin.v1.UpdateRole"
  EOF
}

module "vpc-network-firewall-alert" {
  source = "../custom-alert-policy"

  name = "vpc/network_firewall"
  policy_display_name = "VPC Network Firewall Change"
  notification_channel_name = "${google_monitoring_notification_channel.notification_channel_email.name}"

  filter = <<EOF
    resource.type="gce_firewall_rule" AND
    jsonPayload.event_subtype = "compute.firewalls.patch" OR
    jsonPayload.event_subtype = "compute.firewalls.insert"
  EOF
}

module "vpc-network-route-alert" {
  source = "../custom-alert-policy"

  name = "vpc/network_route"
  policy_display_name = "VPC network route Change"
  notification_channel_name = "${google_monitoring_notification_channel.notification_channel_email.name}"

  filter = <<EOF
    resource.type = "gce_route" AND
    jsonPayload.event_subtype = "compute.routes.delete" OR
    jsonPayload.event_subtype = "compute.routes.insert"
  EOF
}

module "vpc-network-alert" {
  source = "../custom-alert-policy"

  name = "vpc/network"
  policy_display_name = "VPC network Change"
  notification_channel_name = "${google_monitoring_notification_channel.notification_channel_email.name}"

  filter = <<EOF
    resource.type=gce_network AND
    jsonPayload.event_subtype = "compute.networks.insert" OR
    jsonPayload.event_subtype = "compute.networks.patch" OR
    jsonPayload.event_subtype = "compute.networks.delete" OR
    jsonPayload.event_subtype = "compute.networks.removePeering" OR
    jsonPayload.event_subtype = "compute.networks.addPeering"
  EOF
}

module "cloud-storage-iam-permission-alert" {
  source = "../custom-alert-policy"

  name = "cloud-storage/iam-permission"
  policy_display_name = "Cloud Storage IAM permission Change"
  notification_channel_name = "${google_monitoring_notification_channel.notification_channel_email.name}"

  filter = <<EOF
    resource.type = gcs_bucket AND
    protoPayload.methodName = "storage.setIamPermissions"
  EOF
}

module "sql-instance-configuration-alert" {
  source = "../custom-alert-policy"

  name = "sql-instance/configuration"
  policy_display_name = "SQL Instance Configuration Change"
  notification_channel_name = "${google_monitoring_notification_channel.notification_channel_email.name}"

  filter = <<EOF
    protoPayload.methodName = "cloudsql.instances.update"
  EOF
}