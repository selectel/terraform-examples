variable "username" {}

variable "password" {}

variable "domain_name" {}

variable "user_password" {}

variable "project_name" {
  default = "routing_example_project"
}

variable "project_user_name" {
  default = "routing_example_user"
}

variable "keypair_name" {
  default = "routing_example_keypair"
}

variable "auth_url" {
  default = "https://cloud.api.selcloud.ru/identity/v3"
}

variable "target_zone" {
  default = "ru-9a"
}

variable "server_image_name" {
  default = "Ubuntu 22.04 LTS 64-bit"
}
