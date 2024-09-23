variable "cluster_id" {}

variable "project_id" {}

variable "region" {}

variable "availability_zone" {}

variable "nodes_count" {
  default = 1
}

variable "keypair_name" {
  default = ""
}

variable "affinity_policy" {
  default = ""
}

variable "cpus" {
  default = 1
}

variable "ram_mb" {
  default = 4096
}

variable "volume_gb" {
  default = 20
}

variable "volume_type" {}

variable "user_data" {
  default = ""
}

variable "install_nvidia_device_plugin" {
  default = false
}

variable "labels" {}

variable "taints" {}
