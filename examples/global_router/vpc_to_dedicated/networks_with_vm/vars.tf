variable "target_zone" {}

# Networking
variable "server_name" {
  default = "terraform-serv"
}
variable "dns_nameservers" {
  default = ["188.93.16.19", "188.93.17.19"]
}
variable "subnet_cidr1" {}
variable "dest_subnet_cidr1" {}
variable "vm_ip1" {}
variable "gw_ip1" {}
variable "router_ip1" {}

# Instances
variable "public_ssh_key" {}
variable "server_image_name" {
  default = "Ubuntu 22.04 LTS 64-bit"
}
variable "user_data1" {
  default = ""
}
