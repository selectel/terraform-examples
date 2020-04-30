variable "sel_token" {}

variable "project_name" {
  default = "tf-project"
}

variable "cluster_name" {
  default = "tf-cluster"
}

variable "region" {
  default = "ru-3"
}

variable "kube_version" {
  default = "1.16.8"
}

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

variable "availability_zone" {
  default = "ru-3a"
}

variable "nodes_count" {
  default = 3
}

variable "keypair_name" {
  default = ""
}

variable "affinity_policy" {
  default = ""
}

variable "cpus" {
  default = 2
}

variable "ram_mb" {
  default = 2048
}

variable "volume_gb" {
  default = 20
}

variable "volume_type" {
  default = "fast.ru-3a"
}
