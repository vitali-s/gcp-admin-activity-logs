module "log_export" {
  source                 = "terraform-google-modules/log-export/google"
  destination_uri        = "${module.destination.destination_uri}"
  filter                 = "severity >= ERROR"
  log_sink_name          = "pubsub_example_logsink"
  parent_resource_id     = "sample-project"
  parent_resource_type   = "project"
  unique_writer_identity = "true"
}

module "destination" {
  source                   = "terraform-google-modules/log-export/google//modules/pubsub"
  project_id               = "sample-project"
  topic_name               = "sample-topic"
  log_sink_writer_identity = "${module.log_export.writer_identity}"
  create_subscriber        = "true"
}
