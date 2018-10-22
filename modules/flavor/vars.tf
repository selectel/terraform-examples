variable "flavor_name" {
  description = "Name of the OpenStack Compute Flavor"
  default     = "flavor_1"
}

variable "flavor_vcpus" {
  description = "Amount of VCPUs for the OpenStack Compute Flavor"
  default     = 2
}

variable "flavor_ram_mb" {
  description = "Amount of RAM for the OpenStack Compute Flavor"
  default     = 2048
}

variable "flavor_local_disk_gb" {
  description = "Amount of GB for local storage of the OpenStack Compute Flavor"
  default     = 0
}

variable "flavor_is_public" {
  description = "Flavor visibility"
  default     = false
}