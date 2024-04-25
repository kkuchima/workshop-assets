# allow access from health check ranges
resource "google_compute_firewall" "default" {
  name          = "l7-xlb-fw-allow-hc"
  provider      = google
  project       = var.project_id
  direction     = "INGRESS"
  network       = var.network_name
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  allow {
    protocol = "tcp"
    ports = ["80","443"]
  }
}