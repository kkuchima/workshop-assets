output "dns_name" {
  description = "DNS name for PSC connection"
  value       = google_sql_database_instance.main.dns_name
}

output "psc_attachment" {
  description = "value"
  value       = google_sql_database_instance.main.psc_service_attachment_link
}
