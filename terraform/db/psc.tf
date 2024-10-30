resource "google_compute_address" "default" {
  name         = "psc-compute-address-${google_sql_database_instance.main.name}"
  region       = "asia-northeast1"
  address_type = "INTERNAL"
  subnetwork   = "default"     # Replace value with the name of the subnet here.
  address      = "10.146.0.43" # Replace value with the IP address to reserve.
}

data "google_sql_database_instance" "default" {
  name = resource.google_sql_database_instance.main.name
}

resource "google_compute_forwarding_rule" "default" {
  name                  = "psc-forwarding-rule-${google_sql_database_instance.main.name}"
  region                = "asia-northeast1"
  network               = "default"
  ip_address            = google_compute_address.default.self_link
  load_balancing_scheme = ""
  target                = data.google_sql_database_instance.default.psc_service_attachment_link
}
