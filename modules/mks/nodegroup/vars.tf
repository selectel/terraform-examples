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
  default = 1024
}

variable "volume_gb" {
  default = 10
}

variable "volume_type" {}
