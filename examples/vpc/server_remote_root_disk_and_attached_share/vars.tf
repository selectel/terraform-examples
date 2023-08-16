variable "username" {}

variable "password" {}

variable "domain_name" {}

variable "project_name" {
  default = "tf_project"
}

variable "project_user_name" {
  default = "tf_user"
}

variable "user_password" {}

variable "auth_url" {
  default = "https://api.selvpc.ru/identity/v3"
}

variable "flavor_id" {
  default = "1011" # SL1.1-1024
}

variable "server_volume_type" {
  default = "basic.ru-9a"
}

variable "server_volume_size" {
  default = 5
}

variable "subnet_cidr" {
  default = "192.168.0.0/24"
}

variable "base_name" {
  default = "share_example"
}

variable "server_image_name" {
  default = "Ubuntu 22.04 LTS 64-bit"
}

variable "server_zone" {
  default = "ru-9a"
}

variable "server_region" {
  default = "ru-9"
}

variable "ssh_key_path" {
  default = "~/.ssh/id_rsa"
}

variable "ssh_user" {
  default = "root"
}

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
