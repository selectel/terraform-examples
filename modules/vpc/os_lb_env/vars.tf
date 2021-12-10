variable "target_zone" {}

variable "server_image_name" {}

variable "keypair_name" {
  default = ""
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
