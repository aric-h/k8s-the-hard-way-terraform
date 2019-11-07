/*google compute instance vars*/
variable "instance_count" {
  type        = number
  description = "Number of instances to provision"
  default     = 0
}

variable "name_prefix" {
  type        = string
  description = "Prefix for instance name"
}

variable "machine_type" {
  type        = string
  description = "Type of instance to provision"
}

variable "zone" {
  type        = string
  description = "Zone to provision resources in"
}

variable "can_ip_forward" {
  type        = bool
  description = "Boolean; can the instance IP forward"
}

variable "tags" {
  type        = list(string)
  description = "Tags to apply to instances"
}

variable "boot_disk_size" {
  type        = number
  description = "Size of the boot disk"
}

variable "boot_disk_image" {
  type        = string
  description = "Image to create the boot disk from"
}

variable "subnet" {
  type        = string
  description = "Name of subnet to provision instances in"
}

variable "network_ip_prefix" {
  type        = string
  description = "IP address to apply to each instance, minus the count.index"
}

variable "pod_cidr" {
  type        = string
  description = "Cidr block for pod network"
  default     = ""
}