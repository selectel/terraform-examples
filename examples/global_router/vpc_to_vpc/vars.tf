# initialization
variable "username" {}
variable "project_name" {}
variable "project_id" {}
variable "password" {}
variable "domain_name" {}
variable "auth_url" {
  default = "https://cloud.api.selcloud.ru/identity/v3"
}

# Networking ru-1
variable "subnet_cidr11" {
  default = "10.1.11.0/24"
}
variable "gw_ip11" {
  default = "10.1.11.2"
}
variable "vm_ip11" {
  default = "10.1.11.3"
}
variable "router_ip11" {
  default = "10.1.11.1"
}
variable "target_zone1" {
  default = "ru-1a"
}
variable "region_name1" {
  default = "ru-1"
}
variable "gr_service_addresses11" {
  default = ["10.1.11.253", "10.1.11.254"]
}

# Networking ru-2
variable "subnet_cidr21" {
  default = "10.2.11.0/24"
}
variable "gw_ip21" {
  default = "10.2.11.2"
}
variable "vm_ip21" {
  default = "10.2.11.3"
}
variable "router_ip21" {
  default = "10.2.11.1"
}
variable "target_zone2" {
  default = "ru-2a"
}
variable "region_name2" {
  default = "ru-2"
}
variable "gr_service_addresses21" {
  default = ["10.2.11.253", "10.2.11.254"]
}


# Instances
variable "server_image_name" {
  default = "Ubuntu 20.04 LTS 64-bit"
}
variable "user_data1" {
  default = ""
}
