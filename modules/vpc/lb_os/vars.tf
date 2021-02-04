variable "target_zone" {}

variable "server_image_name" {}

variable "count_of_servers" {}

variable "keypair_name" {}

variable "lb_flavor_id" {}

variable "lb_components" {
  default = ""
}

variable "lb_components_http" {
  default = ""
}

variable "server_vcpus" {
  default = 4
}

variable "server_ram_mb" {
  default = 8192
}

variable "server_root_disk_gb" {
  default = 32
}
