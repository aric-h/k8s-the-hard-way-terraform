/*provider*/
provider "google" {
  credentials = var.creds_location
  project     = var.project_id
  region      = var.project_region
  zone        = var.project_zone

  version = ">=2.17.0"
}

/*data sources*/
data "google_compute_image" "k8s_ubuntu" {
  project = var.gci_project
  name    = var.gci_name
}

/*vpc resources*/
resource "google_compute_network" "default" {
  name                    = var.vpc_name
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "default" {
  ip_cidr_range = var.subnet_cidr_block
  name          = var.subnet_name
  network       = google_compute_network.default.self_link
}

resource "google_compute_firewall" "internal" {
  name    = var.internal_firewall_name
  network = google_compute_network.default.name

  dynamic "allow" {
    for_each = var.internal_allow_protocol
    content {
      protocol = allow.value["protocol"]
    }
  }

  source_ranges = var.internal_allow_sources_ranges
}

resource "google_compute_firewall" "external" {
  name    = var.external_firewall_name
  network = google_compute_network.default.name

  dynamic "allow" {
    for_each = var.external_allow_protocol
    content {
      protocol = allow.value["protocol"]
      ports    = allow.value["ports"]
    }
  }

  source_ranges = var.external_allow_source_ranges
}

resource "google_compute_address" "default" {
  name = var.external_ip_name
}

/*controller resources*/
module "k8s_controllers" {
  source = "./modules/google_compute_instance"

  instance_count    = var.controller_count
  name_prefix       = var.controller_name_prefix
  machine_type      = var.controller_machine_type
  zone              = var.project_zone
  tags              = var.controller_tags
  can_ip_forward    = var.controller_ip_forward
  subnet            = google_compute_subnetwork.default.name
  network_ip_prefix = join(".", [local.subnet_cidr_prefix, "1"])
  boot_disk_size    = var.controller_boot_disk_size
  boot_disk_image   = join("/", [var.boot_disk_image_project, var.boot_disk_image_family])
}

/*worker resources*/
module "k8s_workers" {
  source = "./modules/google_compute_instance"

  instance_count    = var.worker_count
  name_prefix       = var.worker_name_prefix
  machine_type      = var.worker_machine_type
  zone              = var.project_zone
  tags              = var.worker_tags
  can_ip_forward    = var.worker_ip_forward
  subnet            = google_compute_subnetwork.default.name
  network_ip_prefix = join(".", [local.subnet_cidr_prefix, "2"])
  boot_disk_size    = var.worker_boot_disk_size
  boot_disk_image   = join("/", [var.boot_disk_image_project, var.boot_disk_image_family])
  pod_cidr          = var.worker_pod_cider
}