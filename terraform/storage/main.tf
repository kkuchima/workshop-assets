variable "project_id" {}

provider "google" {
  project = var.project_id
}

resource "random_id" "bucket_prefix" {
  byte_length = 4
}

resource "google_storage_bucket" "state_bucket" {
  name     = "${var.project_id}-state-bucket-${random_id.bucket_prefix.dec}"
  location = "asia-northeast1"

  force_destroy               = false
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
  lifecycle_rule {
    condition {
      age = 5
    }
    action {
      type = "Delete"
    }
  }
}