provider "google" {
  project = var.project_id
}

resource "google_sql_database_instance" "main" {
  name             = "psc-enabled-main-instance"
  region           = "asia-northeast1"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      psc_config {
        psc_enabled               = true
        allowed_consumer_projects = [var.project_id]
      }
      ipv4_enabled = false
    }
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }
    availability_type = "REGIONAL"
  }
}

resource "google_sql_database" "default" {
  name     = "default"
  instance = google_sql_database_instance.main.name
}

resource "google_sql_user" "default" {
  name     = "default"
  instance = google_sql_database_instance.main.name
  password = "your-strong-password" # 必ず強力なパスワードを設定してください
}
