/******************************************
  Service Project Creation
 *****************************************/
module "service-project" {
  source  = "terraform-google-modules/project-factory/google//modules/svpc_service_project"
  version = "~> 14.0"

  name              = var.project_id
  random_project_id = false

  org_id          = var.organization_id
  folder_id       = var.folder_id
  billing_account = var.billing_account

  shared_vpc         = var.host_project_id
  shared_vpc_subnets = var.shared_subnet

  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
  ]
  default_service_account     = "keep"
  disable_services_on_destroy = false
}