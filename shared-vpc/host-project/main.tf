locals {
  subnet_01 = "${var.network_name}-subnet-01"
  subnet_02 = "${var.network_name}-subnet-02"
}

/******************************************
  Host Project Creation
 *****************************************/
module "host-project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 14.0"

  random_project_id              = false
  name                           = var.project_id
  org_id                         = var.organization_id
  folder_id                      = var.folder_id
  billing_account                = var.billing_account
  enable_shared_vpc_host_project = true

  activate_apis = [
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "container.googleapis.com",
  ]

}

/******************************************
  Network Creation
 *****************************************/
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.0"

  project_id                             = module.host-project.project_id
  network_name                           = var.network_name
  delete_default_internet_gateway_routes = false

  subnets = [
    {
      subnet_name           = local.subnet_01
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "asia-northeast1"
      subnet_private_access = true
      subnet_flow_logs      = false
    },
    {
      subnet_name           = local.subnet_02
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "asia-northeast1"
      subnet_private_access = true
      subnet_flow_logs      = false
    },
  ]

  secondary_ranges = {
    (local.subnet_01) = [
      {
        range_name    = "pod"
        ip_cidr_range = "10.0.0.0/17"
      },
      {
        range_name    = "service"
        ip_cidr_range = "10.0.200.0/22"
      },
    ]

    (local.subnet_02) = [
      {
        range_name    = "${local.subnet_02}-01"
        ip_cidr_range = "192.168.66.0/24"
      },
    ]
  }
}