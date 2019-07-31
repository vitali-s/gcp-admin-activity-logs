module "audit-logs-retention" {
  source = "./modules/audit-logs-retention"

  project = var.project
}

module "audit-logs-analysis" {
  source = "./modules/audit-logs-analysis"

  project = var.project
}
