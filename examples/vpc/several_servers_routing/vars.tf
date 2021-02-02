variable "sel_token" {}

variable "user_password" {}

variable "project_name" {
  default = "routing_example_project"
}

variable "user_name" {
  default = "routing_example_user"
}

variable "keypair_name" {
  default = "routing_example_keypair"
}

variable "os_auth_url" {
  default = "https://api.selvpc.ru/identity/v3"
}

variable "target_zone" {
  default = "ru-3a"
}

variable "server_image_name" {
  default = "Ubuntu 18.04 LTS 64-bit"
}
