provider "google" {
  credentials = "${file("~/.gcp/account.json")}"
  project     = var.project
  region      = "us-west1"
  zone        = "us-west1-a"
}
