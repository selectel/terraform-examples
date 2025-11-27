# initialization
variable "username" {}
variable "project_name" {}
variable "project_id" {}
variable "password" {}
variable "domain_name" {}
variable "auth_url" {
  default = "https://cloud.api.selcloud.ru/identity/v3"
}

# Networking cloud
variable "subnet_cidr1" {
  default = "10.1.11.0/24"
}
variable "gw_ip11" {
  default = "10.1.11.2"
}
variable "vm_ip11" {
  default = "10.1.11.1"
}
variable "router_ip11" {
  default = "10.1.11.3"
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

# Networking dedicated
variable "price_plan_name" {
  default = "1 day"
}
variable "subnet_cidr2" {
  default = "10.2.11.0/24"
}
variable "gw_ip21" {
  default = "10.2.11.1"
}
variable "region_name2" {
  default = "SPB-1"
}
variable "dedicated_vlan" {
  default = "1234"
}
variable "gr_service_addresses21" {
  default = ["10.2.11.253", "10.2.11.254"]
}


# Instances
variable "public_ssh_key" {}
variable "server_image_name" {
  default = "Ubuntu 20.04 LTS 64-bit"
}
variable "user_data1" {
  default = ""
}
