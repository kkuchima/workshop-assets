provider "google" {
  project = var.project_id
}

resource "google_container_cluster" "autopilot-cluster" {
  name             = var.cluster_name
  location         = var.cluster_region
  network          = "projects/${var.project_id}/global/networks/${var.network}"
  subnetwork       = "projects/${var.project_id}/regions/${var.cluster_region}/subnetworks/${var.subnet_name}"
  enable_autopilot = true

  release_channel {
    channel = "STABLE"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    //    master_ipv4_cidr_block  = "10.0.2.0/28"
  }

  //  ip_allocation_policy {
  //    cluster_secondary_range_name  = var.pod_2nd_range
  //    services_secondary_range_name = var.service_2nd_range
  //  }

  lifecycle {
    ignore_changes = [node_pool, initial_node_count]
  }

  timeouts {
    create = "45m"
    update = "45m"
    delete = "45m"
  }
}
