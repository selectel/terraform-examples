variable "cluster_name" {
  default = "cluster-1"
}

variable "project_id" {}

variable "region" {}

variable "kube_version" {}

variable "enable_autorepair" {
  default = true
}

variable "enable_patch_version_auto_upgrade" {
  default = true
}

variable "network_id" {
  default = ""
}

variable "subnet_id" {
  default = ""
}

variable "maintenance_window_start" {
  default = ""
}
