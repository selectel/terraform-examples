variable "server_network_id" {}

variable "server_subnet_id" {}

variable "server_image_name" {}

variable "keypair_name" {}

variable "server_name" {
  default = "server"
}

variable "server_zone" {
  default = "ru-3a"
}

variable "replicas_count" {
  default = 1
}

variable "server_vcpus" {
  default = 4
}

variable "server_ram_mb" {
  default = 8192
}

variable "server_root_disk_gb" {
  default = 8
}
