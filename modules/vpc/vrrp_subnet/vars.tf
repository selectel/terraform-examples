variable "vrrp_subnet_project_id" {}

variable "vrrp_subnet_master_region" {}

variable "vrrp_subnet_slave_region" {}

variable "vrrp_subnet_prefix_length" {
  default = 29
}

variable "vrrp_subnet_ip_version" {
  default = "ipv4"
}
