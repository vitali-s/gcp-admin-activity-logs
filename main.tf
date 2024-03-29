module "audit-logs-retention" {
  source = "./modules/audit-logs-retention"

  project = var.project
}

module "audit-logs-analysis" {
  source = "./modules/audit-logs-analysis"

  project = var.project
}

module "audit-logs-alerts" {
  source = "./modules/audit-logs-alerts"

  notification_email_address = "email@email.com"
}
