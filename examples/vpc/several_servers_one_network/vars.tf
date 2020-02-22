variable "sel_account" {}

variable "sel_token" {}

variable "project_name" {
  default = "tf_project"
}

variable "user_name" {
  default = "tf_user"
}

variable "user_password" {}

variable "keypair_name" {
  default = "tf_keypair"
}

variable "os_auth_url" {
  default = "https://api.selvpc.ru/identity/v3"
}

variable "os_region" {
  default = "ru-3"
}

variable "count_of_servers" {
  default = 2
}


variable "server_name" {
  default = "tf_server"
}

variable "server_zone" {
  default = "ru-3a"
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
  default = "fast.ru-3a"
}

variable "server_image_name" {
  default = "Ubuntu 18.04 LTS 64-bit"
}