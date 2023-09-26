variable "username" {}

variable "password" {}

variable "domain_name" {}

variable "user_password" {}

variable "project_name" {
  default = "fwaas_project"
}

variable "project_user_name" {
  default = "fwaas_user"
}

variable "auth_url" {
  default = "https://api.selvpc.ru/identity/v3"
}

variable "region" {
  default = "ru-3"
}

variable "server_name" {
  default = "tf_server"
}

variable "server_zone" {
  default = "ru-3a"
}

variable "server_volume_type" {
  default = "fast.ru-3a"
}

variable "server_flavor_id" {
  default = "1011"
}

variable "server_image_name" {
  default = "Ubuntu 22.04 LTS 64-bit"
}

variable "server_root_disk_gb" {
  default = 8
}
