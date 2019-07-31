variable "project" {
  description = "Project id to add the IAM policies/bindings for Log Viewers"
}

variable "region" {
  description = "The bucket region, default region is 'US'."
  default     = "US"
}

variable "storage_class" {
  description = "Audit logs bucket storage class, default value is NEARLINE"
  default     = "NEARLINE"
}

variable "environment_label" {
  description = "Environment label, default value is Production"
  default     = "Production"
}

variable "name_prefix" {
  description = "Bucket name prefix, default value is 'audit-logs-'"
  default     = "audit-logs-"
}

variable "sink_name" {
  description = "Audit logs sink name, default value is 'audit-logs-retention-sink'"
  default     = "audit-logs-retention-sink"
}

variable "resource_id" {
  description = "Audit logs sink resource id, could be organization id, folder or project id, default value is project id"
  default     = ""
}

variable "resource_type" {
  description = "Audit logs sink resource type, default value is 'project'"
  default     = "project"
}