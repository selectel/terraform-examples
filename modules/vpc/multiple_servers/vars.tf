variable "server_image_name" {}

variable "server_ssh_key" {}

variable "server_ssh_key_user" {}

variable "server_name" {
  default = "server"
}

variable "server_zone" {
  default = "ru-9a"
}

variable "replicas_count" {
  default = 1
}

variable "server_vcpus" {
  default = 1
}

variable "server_ram_mb" {
  default = 1024
}

variable "server_root_disk_gb" {
  default = 5
}
