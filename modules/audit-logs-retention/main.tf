module "audit_logs_export" {
  source                 = "terraform-google-modules/log-export/google"
  destination_uri        = module.audit_logs_sink.destination_uri
  filter                 = "logName=\"projects/${var.project}/logs/cloudaudit.googleapis.com%2Factivity\""
  log_sink_name          = var.sink_name
  parent_resource_id     = "${length(var.resource_id) > 0 ? var.resource_id : var.project}"
  parent_resource_type   = var.resource_type
  unique_writer_identity = "true"
}

module "audit_logs_sink" {
  source                   = "terraform-google-modules/log-export/google//modules/storage"
  project_id               = var.project
  storage_bucket_name      = "${var.name_prefix}${var.project}"
  log_sink_writer_identity = module.audit_logs_export.writer_identity
  storage_class            = var.storage_class
  location                 = var.region
}
