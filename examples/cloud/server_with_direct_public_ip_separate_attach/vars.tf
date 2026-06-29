variable "username" {}

variable "password" {
  sensitive = true
}

variable "domain_name" {}

variable "project_name" {
  default = "tf_project"
}

variable "project_user_name" {
  default = "tf_user"
}

variable "user_password" {
  sensitive = true
}

variable "auth_url" {
  default = "https://cloud.api.selcloud.ru/identity/v3"
}

variable "region" {
  default = "ru-6"
}

variable "keypair_path" {
  default = "~/.ssh/id_ed25519.pub"
}

variable "server_name" {
  default = "tf_server"
}

variable "server_zone" {
  default = "ru-6a"
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

variable "server_image_name" {
  default = "Ubuntu 22.04 LTS 64-bit"
}
