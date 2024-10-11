variable "username" {}

variable "password" {}

variable "domain_name" {}

variable "project_name" {
  default = "tf-project"
}

variable "cluster_name" {
  default = "tf-cluster"
}

variable "region" {
  default = "ru-9"
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
  default = "ru-9a"
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
  default = 4096
}

variable "volume_gb" {
  default = 30
}

variable "volume_type" {
  default = "fast.ru-9a"
}

variable "user_data" {
  default = "IyEvYmluL2Jhc2ggLXYKYXB0IC15IHVwZGF0ZQphcHQgLXkgaW5zdGFsbCBtdHI="
}

variable "install_nvidia_device_plugin" {
  default = false
}

variable "labels" {
  default = {
    "label1" : "value1",
    "label2" : "value2"
  }
}

variable "taints" {
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default = [{
    effect = "NoSchedule"
    key    = "key3"
    value  = "value3"
    },
    {
      effect = "NoSchedule"
      key    = "key2"
      value  = "value2"
  }]
}
