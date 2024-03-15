variable "organization_id" {
  description = "The organization id for the associated services"
}

variable "folder_id" {
  description = "The folder to create projects in"
}

variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
}

variable "project_id" {
  description = "Name for Shared VPC service project"
}

variable "host_project_id" {
  description = "Name for Shared VPC host project"
}

variable "network_name" {
  description = "Name for Shared VPC network"
}

variable "shared_subnet" {
  description = "URI for Shared VPC subnet"
}