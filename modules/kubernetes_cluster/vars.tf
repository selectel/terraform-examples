variable "cluster_name" {
  description = "Name of the OpenStack Container Infra Cluster"
  default     = "cluster_1"
}

variable "cluster_template_id" {
  description = "ID of the OpenStack Container Infra Cluster Template"
}

variable "cluster_keypair" {
  description = "Name for the Keypair of the OpenStack Container Infra Cluster"
}

variable "cluster_master_flavor" {
  description = "Reference of the flavor for the OpenStack Container Infra Cluster nodes"
  default     = "1003"
}

variable "cluster_flavor" {
  description = "Reference of the flavor for the OpenStack Container Infra Cluster master nodes"
  default     = "1003"
}

variable "cluster_master_count" {
  description = "Count of the OpenStack Container Infra Cluster master nodes"
  default     = "3"
}

variable "cluster_node_count" {
  description = "Count of the OpenStack Container Infra Cluster nodes"
  default     = "3"
}
