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
  default = "https://api.selvpc.ru/identity/v3"
}

variable "server_name" {
  default = "tf_server"
}

variable "server_zone" {
  default = "ru-3a"
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
  default = "fast.ru-3a"
}

variable "server_image_name" {
  default = "Ubuntu 18.04 LTS 64-bit"
}

variable "server_group_policy" {
  default = ["anti-affinity"]
}

variable "server_group_name" {
  default = "anti_affinity_group"
}
