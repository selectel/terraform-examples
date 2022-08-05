variable "sel_token" {}

variable "os_auth_url" {
  default = "https://api.selvpc.ru/identity/v3/auth/"
}

variable "user_name" {
  default = "tf-user"
}

variable "user_password" {}

variable "project_name" {
  default = "tf-project"
}

variable "cluster_name" {
  default = "tf-cluster"
}

variable "region" {
  default = "ru-9"
}

variable "subnet_cidr" {
  default = "10.222.0.0/16"
}

variable "kube_version" {
  default = "1.23.6"
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
  default = 2
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
  default = 32
}

variable "volume_type" {
  default = "fast.ru-9a"
}

variable "labels" {
  default = {
    "label1":"value1", 
    "label2":"value2"
  }
}

variable "taints" {
  type = list(object({
    key = string
    value = string
    effect =string
  }))
  default =[ {
    effect = "NoSchedule"
    key = "key3"
    value = "value3"
  },
  {
    effect = "NoSchedule"
    key = "key2"
    value = "value2"
  } ]
}
