variable "project_user_name" {}

variable "project_name" {}

variable "user_password" {}

variable "domain_name" {}

variable "auth_url" {}

variable "region" {}

variable "server_vcpus" {
  default = 4
}

variable "server_ram_mb" {
  default = 8192
}

variable "server_root_disk_gb" {
  default = 8
}

variable "server_second_disk_gb" {
  default = 5
}

variable "server_second_volume_type" {
  default = "fast.ru-3a"
}

variable "server_name" {
  default = "server_1"
}

variable "server_image_name" {}

variable "server_zone" {
  default = "ru-3a"
}

variable "server_ssh_key" {}

variable "server_ssh_key_user" {}
