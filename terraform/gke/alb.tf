# Data source to fetch the existing NEG
data "google_compute_network_endpoint_group" "guestbook_neg" {
  name = "neg-guestbook"
  zone = "asia-northeast1-b" 
}

# Create a health check for the load balancer
resource "google_compute_health_check" "http_health_check" {
  name               = "alb-health-check"
  check_interval_sec = 5
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2

  http_health_check {
    port = 80
  }
}

# Create a backend service for the ALB
resource "google_compute_backend_service" "guestbook_backend" {
  name          = "alb-backend-service"
  protocol      = "HTTP"
  port_name     = "http"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  security_policy = google_compute_security_policy.stdpolicy.id
  health_checks = [google_compute_health_check.http_health_check.id]
  backend {
    group = data.google_compute_network_endpoint_group.guestbook_neg.id
    balancing_mode = "RATE"
    max_rate = "100"
  }
}

# Create a URL map to direct traffic
resource "google_compute_url_map" "guestbook_url_map" {
  name        = "alb-url-map"
  description = "URL map for the guestbook application"
  default_service = google_compute_backend_service.guestbook_backend.id
}

# Create a target HTTP Proxy to use the URL map
resource "google_compute_target_http_proxy" "guestbook_http_proxy" {
  name    = "alb-http-proxy"
  url_map = google_compute_url_map.guestbook_url_map.id
}

# Create the external HTTP(S) load balancer 
resource "google_compute_global_forwarding_rule" "forwarding-rule" {
  name       = "alb-forwarding-rule"
  ip_protocol = "TCP"
  port_range = "80"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  target     = google_compute_target_http_proxy.guestbook_http_proxy.id
}