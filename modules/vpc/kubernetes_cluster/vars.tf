variable "os_user_name" {}

variable "os_project_name" {}

variable "os_user_password" {}

variable "os_domain_name" {}

variable "os_auth_url" {}

variable "os_region" {}

variable cluster_master_vcpus {
  default = 2
}

variable cluster_master_ram {
  default = 2048
}

variable cluster_node_vcpus {
  default = 2
}

variable cluster_node_ram {
  default = 2048
}

variable external_net_name {
  default = "external-network"
}

variable cluster_image_name {
  default = "Fedora Atomic 27 64-bit"
}

variable cluster_ssh_key {}

variable cluster_ssh_key_user {}

variable cluster_name {
  default = "tf_cluster"
}

variable cluster_kube_version {
  default = "v1.12.4"
}

variable cluster_zone {
  default = "ru-3a"
}

variable cluster_master_count {
  default = 1
}

variable cluster_node_count {
  default = 2
}

variable cluster_master_lb_enabled {
  default = false
}

variable cluster_floating_ip_enabled {
  default = false
}

variable cluster_kube_dashboard_enabled {
  default = "true"
}

variable cluster_prometheus_monitoring {
  default = "true"
}

variable cluster_influx_grafana_dashboard_enabled {
  default = "true"
}

variable cluster_docker_volume_size {
  default = 10
}

variable cluster_etcd_volume_size {
  default = "10"
}

variable cluster_master_floating_ip {
  default = "false"
}
