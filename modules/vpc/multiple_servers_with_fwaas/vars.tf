variable "server_image_name" {}

variable "server_ssh_key" {}

variable "server_ssh_key_user" {}

variable "server_root_disk_gb" {}

variable "server_volume_type" {}

variable "server_name" {
  default = "server"
}

variable "server_zone" {
  default = "ru-9a"
}

variable "server_flavor_id" {
  default = "1011"
}
