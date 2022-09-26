variable "sel_account" {}

variable "sel_token" {}

variable "project_id" {}

variable "region" {}

variable "user_name" {}

variable "user_password" {}

variable "redis_password" {}

variable "os_auth_url" {
  default = "https://api.selvpc.ru/identity/v3"
}

variable "network_name" {
  default = "nat"
}
