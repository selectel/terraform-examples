variable "username" {}

variable "password" {}

variable "domain_name" {}

variable "project_name" {
  default = "tf_project"
}

variable "project_user_name" {
  default = "tf_user"
}

variable "user_password" {}

variable "keypair_name" {
  default = "tf_keypair"
}

variable "auth_url" {
  default = "https://cloud.api.selcloud.ru/identity/v3"
}

variable "region" {
  default = "ru-9"
}

variable "count_of_servers" {
  default = 2
}


variable "server_name" {
  default = "tf_server"
}

variable "server_zone" {
  default = "ru-9a"
}

variable "server_vcpus" {
  default = 1
}

variable "server_ram_mb" {
  default = 4096
}

variable "server_root_disk_gb" {
  default = 8
}

variable "server_volume_type" {
  default = "fast.ru-9a"
}

variable "server_image_name" {
  default = "Ubuntu 22.04 LTS 64-bit"
}
