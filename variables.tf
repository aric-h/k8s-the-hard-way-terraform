/*provider vars*/
variable "creds_location" {
  type        = string
  description = "Path to gcloud json credential file"
}

variable "project_id" {
  type        = string
  description = "ID of the project to deploy to"
}

variable "project_region" {
  type        = string
  description = "Region to deploy resources"
}

variable "project_zone" {
  type        = string
  description = "Zone to deploy resources"
}

/*data vars*/
variable "gci_project" {
  type        = string
  description = "Project from which image originates"
}

variable "gci_name" {
  type        = string
  description = "Name of image"
}

/*vpc vars*/
variable "vpc_name" {
  type        = string
  description = "Name for VPC"
}

variable "subnet_cidr_block" {
  type        = string
  description = "CIDR block for subnet"
}

variable "subnet_name" {
  type        = string
  description = "Name of subnet"
}

variable "internal_firewall_name" {
  type        = string
  description = "Name of internal firewall"
}

variable "internal_allow_protocol" {
  type = list(object({
    protocol = string
    ports    = list(string)
  }))
  description = "Protocols to allow on internal firewall"
}

variable "internal_allow_sources_ranges" {
  type        = list(string)
  description = "List of CIDR blocks to allow traffic from"
}

variable "external_firewall_name" {
  type        = string
  description = "Name of external firewall"
}

variable "external_allow_protocol" {
  type = list(object({
    protocol = string
    ports    = list(string)
  }))
  description = "Protocols to allow on external firewall"
}

variable "external_allow_source_ranges" {
  type        = list(string)
  description = "List of CIDR blocks to allow traffic from"
}

variable "external_ip_name" {
  type        = string
  description = "Name for Google compute (public) address"
}

/*boot disk vars*/
variable "boot_disk_image_project" {
  type        = string
  description = "Project that boot disk image belongs to"
}

variable "boot_disk_image_family" {
  type        = string
  description = "Family that boot disk image belongs to"
}

/*k8s controller vars*/
variable "controller_count" {
  type        = number
  description = "Number of controller instances to provision"
}

variable "controller_name_prefix" {
  type        = string
  description = "Prefix for controller instance names"
  default     = "controller-"
}

variable "controller_ip_forward" {
  type        = bool
  description = "Boolean; Can the instance IP forward?"
  default     = true
}

variable "controller_machine_type" {
  type        = string
  description = "Instance type"
}

variable "controller_boot_disk_size" {
  type        = number
  description = "Size of the boot disk of each instance"
}

variable "controller_tags" {
  type        = list(string)
  description = "Tags to apply to controller instances"
}

variable "controller_scopes" {
  type        = list(string)
  description = ""
}

variable "controller_metadata" {
  type = map(string)
  description = "Metadata to apply to controller instances"
  default = {}
}

locals {
  cidr_block_split   = split(".", var.subnet_cidr_block)
  subnet_cidr_prefix = join(".", [local.cidr_block_split[0], local.cidr_block_split[1], local.cidr_block_split[2]])
}

