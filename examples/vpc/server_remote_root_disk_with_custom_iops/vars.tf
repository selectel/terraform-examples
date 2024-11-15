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

variable "server_name" {
  default = "tf_server"
}

variable "server_zone" {
  default = "ru-9a"
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

variable "server_volume_type" {
  default = "universal2.ru-9a"
}

variable "server_volume_metadata" {
  default = {"total_iops_sec": "4500"}
}

variable "server_image_name" {
  default = "Ubuntu 22.04 LTS 64-bit"
}
