variable "base_name" {
  default = "share_example"
}

variable "neutron_net_id" {}

variable "neutron_subnet_id" {}

variable "share_size" {
  default = 50
  type =  number
}

variable "share_proto" {
  default = "NFS"
  type = string
  validation {
    condition = contains(["NFS", "CIFS"], var.share_proto)
    error_message = "Valid values for var: share_proto are (NFS, CIFS)."
  }
}

variable "share_type" {
  default = "basic.ru-9a"
  type = string
}

variable "share_allowed_ip" {
  default = "0.0.0.0/0"
}
