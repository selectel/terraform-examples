variable "username" {}

variable "password" {}

variable "domain_name" {}

variable "project_id" {}

variable "region" {}

variable "auth_url" {
  default = "https://cloud.api.selcloud.ru/identity/v3"
}

variable "network_name" {
  default = "nat"
}
