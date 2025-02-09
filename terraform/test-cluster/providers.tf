provider "google" {
  project = "protean-pipe-447211-g7"
  region  = "us-central1"
}

terraform {
  backend "gcs" {
    bucket      = "terraform-state-test-cluster"
    prefix      = "terraform/state"
  }
}