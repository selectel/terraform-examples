variable "subnet_project_id" {
  description = "Project of the SelVPC V2 Subnet"
}

variable "subnet_region" {
  description = "Region of the SelVPC V2 Subnet"
}

variable "subnet_prefix_length" {
  description = "Prefix length of the SelVPC V2 Subnet"
  default     = 29
}

variable "subnet_ip_version" {
  description = "IP version of the SelVPC V2 Subnet"
  default     = "ipv4"
}
