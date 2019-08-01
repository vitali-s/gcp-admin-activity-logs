variable "project" {
  description = "Project id to add the IAM policies/bindings for Log Viewers"
}

variable "sink_name" {
  description = "Audit logs sink name, default value is 'audit-logs-retention-sink'"
  default     = "audit-logs-analysis-sink"
}

variable "resource_id" {
  description = "Audit logs sink resource id, could be organization id, folder or project id, default value is project id"
  default     = ""
}

variable "resource_type" {
  description = "Audit logs sink resource type, default value is 'project'"
  default     = "project"
}

variable "dataset_name" {
  description = "The name of BigQuery dataset"
  default     = "audit_logs_analysis"
}