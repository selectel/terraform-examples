variable "vrrp_subnet_project_id" {
  description = "Project of the SelVPC V2 VRRP Subnet"
}

variable "vrrp_subnet_master_region" {
  description = "Master region of the SelVPC V2 VRRP Subnet"
}

variable "vrrp_subnet_slave_region" {
  description = "Slave region of the SelVPC V2 VRRP Subnet"
}

variable "vrrp_subnet_prefix_length" {
  description = "Prefix length of the SelVPC V2 VRRP Subnet"
  default     = 29
}

variable "vrrp_subnet_ip_version" {
  description = "IP version of the SelVPC V2 VRRP Subnet"
  default     = "ipv4"
}
