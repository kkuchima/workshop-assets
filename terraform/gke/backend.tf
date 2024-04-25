terraform {
  backend "gcs" {
    bucket = "kkuchima-sandbox-state-bucket-2994677319"
    prefix = "gke"
  }
}