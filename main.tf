module "audit-logs-retention" {
  source = "./modules/audit-logs-retention"

  project = var.project
}
