resource "google_storage_bucket" "terraform_state" {
  name          = "terraform-state-test-cluster"
  location      = "US"
  force_destroy = false

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30
    }
  }
}