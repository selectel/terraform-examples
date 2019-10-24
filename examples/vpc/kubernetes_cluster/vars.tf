variable "sel_account" {}

variable "sel_token" {}

variable "project_name" {
  default = "tf_project"
}

variable "user_name" {
  default = "tf_user"
}

variable "user_password" {}

variable "keypair_name" {
  default = "tf_keypair"
}

variable "os_auth_url" {
  default = "https://api.selvpc.ru/identity/v3"
}

variable "os_region" {
  default = "ru-3"
}

variable "cluster_name" {
  default = "tf_cluster"
}

variable "cluster_zone" {
  default = "ru-3a"
}

variable "cluster_kube_version" {
  default = "v1.15.4"
}

variable "cluster_master_count" {
  default = 1
}

variable "cluster_master_vcpus" {
  default = 2
}

variable "cluster_master_ram" {
  default = 2048
}

variable "cluster_node_count" {
  default = 2
}

variable "cluster_node_vcpus" {
  default = 2
}

variable "cluster_node_ram" {
  default = 2048
}

variable "cluster_master_lb_enabled" {
  default = false
}

variable "cluster_docker_volume_size" {
  default = 10
}

variable "cluster_etcd_volume_size" {
  default = "10"
}

variable "cluster_master_floating_ip" {
  default = "True"
}
