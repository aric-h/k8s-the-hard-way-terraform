/*google compute instance*/
resource "google_compute_instance" "default" {
  count          = var.instance_count
  name           = join("", [var.name_prefix, count.index])
  machine_type   = var.machine_type
  zone           = var.zone
  can_ip_forward = var.can_ip_forward
  tags           = var.tags

  boot_disk {
    initialize_params {
      size  = var.boot_disk_size
      image = var.boot_disk_image
    }
  }

  network_interface {
    subnetwork = var.subnet
    network_ip = join("", [var.network_ip_prefix, count.index])

    access_config {} //needed for ephemeral IP
  }

  metadata = var.pod_cidr == "" ? {} : { pod-cidr = replace(var.pod_cidr, "X", count.index) }
}