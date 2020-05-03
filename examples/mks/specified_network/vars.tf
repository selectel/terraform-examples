variable "sel_account" {}

variable "sel_token" {}

variable "project_name" {
  default = "tf_project"
}

variable "user_name" {
  default = "tf_user"
}

variable "user_password" {}

variable "os_auth_url" {
  default = "https://api.selvpc.ru/identity/v3"
}

variable "os_region" {
  default = "ru-3"
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

variable "maintenance_window_start" {
  default = ""
}

variable "availability_zone" {
  default = "ru-3a"
}

variable "nodes_count" {
  default = 3
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
