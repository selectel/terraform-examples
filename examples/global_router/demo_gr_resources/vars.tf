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
variable "os_network_id" {}
# subnet should have the cidr like subnet_cidr1 and free ip for:
# - next_hop_ip
# - gw_ip1
# - gr_service_addresses1
variable "os_subnet_id" {}
variable "stat_route_cidr" {
  default = "0.0.0.0/0"
}
variable "next_hop_ip" {
  default = "10.1.11.1"
}
variable "subnet_cidr1" {
  default = "10.1.11.0/24"
}
variable "gw_ip1" {
  default = "10.1.11.2"
}
variable "region_cloud" {
  default = "ru-1"
}
variable "gr_service_addresses1" {
  default = ["10.1.11.253", "10.1.11.254"]
}

# Networking SPB-1
variable "subnet_cidr2" {
  default = "10.2.11.0/24"
}
variable "gw_ip2" {
  default = "10.2.11.2"
}
variable "region_dedicated" {}
variable "dedicated_vlan" {}
variable "gr_service_addresses2" {
  default = ["10.2.11.253", "10.2.11.254"]
}
