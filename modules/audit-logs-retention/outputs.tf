output "export_writer_identity" {
  description = "The service account that logging uses to write log entries to the destination."
  value       = module.audit_logs_export.writer_identity
}

output "export_log_sink_resource_id" {
  description = "The resource ID of the log sink that was created."
  value       = module.audit_logs_export.parent_resource_id
}

output "export_log_sink_resource_type" {
  description = "The resource type of the log sink that was created."
  value       = var.resource_type
}