variable "private_network_id" {}

variable "private_subnet_id" {}

variable "public_network_id" {}

variable "public_subnet_id" {}

variable "server_image_name" {}

variable "keypair_name" {}

variable "server_name" {
  default = "server"
}

variable "server_zone" {
  default = "ru-3a"
}

variable "server_vcpus" {
  default = 1
}

variable "server_ram_mb" {
  default = 1024
}

variable "server_root_disk_gb" {
  default = 8
}

variable "user_data" {
  default = ""
}
