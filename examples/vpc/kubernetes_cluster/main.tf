# Initialize Selectel provider with token.
provider "selectel" {
  token = "${var.sel_token}"
}

# Create the main project with user.
# This module should be applied first.
module "project_with_user" {
  source = "../../../modules/vpc/project_with_user"

  project_name  = "${var.project_name}"
  user_name     = "${var.user_name}"
  user_password = "${var.user_password}"
}

# Create an OpenStack Compute instance.
module "kubernetes_cluster" {
  source = "../../../modules/vpc/kubernetes_cluster"

  # OpenStack auth.
  os_project_name  = "${var.project_name}"
  os_user_name     = "${var.user_name}"
  os_user_password = "${var.user_password}"
  os_domain_name   = "${var.sel_account}"
  os_auth_url      = "${var.os_auth_url}"
  os_region        = "${var.os_region}"

  # Kubernetes cluster common parameters.
  cluster_name                 = "${var.cluster_name}"
  cluster_zone                 = "${var.cluster_zone}"
  cluster_kube_version         = "${var.cluster_kube_version}"
  cluster_ssh_key              = "${file("~/.ssh/id_rsa.pub")}"
  cluster_ssh_key_user         = "${module.project_with_user.user_id}"
  cluster_master_lb_enabled    = "${var.cluster_master_lb_enabled}"
  cluster_master_floating_ip   = "${var.cluster_master_floating_ip}"
  cluster_docker_volume_size   = "${var.cluster_docker_volume_size}"
  cluster_etcd_volume_size     = "${var.cluster_etcd_volume_size}"

  # Kubernetes cluster masters parameters.
  cluster_master_count = "${var.cluster_master_count}"
  cluster_master_vcpus = "${var.cluster_master_vcpus}"
  cluster_master_ram   = "${var.cluster_master_ram}"

  # Kubernetes cluster nodes parameters.
  cluster_node_count = "${var.cluster_node_count}"
  cluster_node_vcpus = "${var.cluster_node_vcpus}"
  cluster_node_ram   = "${var.cluster_node_ram}"
}