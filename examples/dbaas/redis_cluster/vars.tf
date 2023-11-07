variable "username" {}

variable "password" {}

variable "domain_name" {}

variable "project_id" {}

variable "region" {}

variable "redis_password" {}

variable "auth_url" {
  default = "https://api.selvpc.ru/identity/v3"
}

variable "network_name" {
  default = "router-nat"
}
