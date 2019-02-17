provider "openstack" {
  user_name           = "${var.os_user_name}"
  tenant_name         = "${var.os_project_name}"
  password            = "${var.os_user_password}"
  project_domain_name = "${var.os_domain_name}"
  user_domain_name    = "${var.os_domain_name}"
  auth_url            = "${var.os_auth_url}"
  region              = "${var.os_region}"
}

resource "random_string" "random_name" {
  length  = 5
  special = false
}

module "master_flavor" {
  source        = "../flavor"
  flavor_name   = "flavor-master-${random_string.random_name.result}"
  flavor_vcpus  = "${var.cluster_master_vcpus}"
  flavor_ram_mb = "${var.cluster_master_ram}"
}

module "flavor" {
  source        = "../flavor"
  flavor_name   = "flavor-${random_string.random_name.result}"
  flavor_vcpus  = "${var.cluster_node_vcpus}"
  flavor_ram_mb = "${var.cluster_node_ram}"
}

module "image_datasource" {
  source     = "../image_datasource"
  image_name = "${var.cluster_image_name}"
}

data "openstack_networking_network_v2" "external_net" {
  name = "${var.external_net_name}"
}

module "keypair" {
  source             = "../keypair"
  keypair_name       = "keypair-${random_string.random_name.result}"
  keypair_public_key = "${var.cluster_ssh_key}"
  keypair_user_id    = "${var.cluster_ssh_key_user}"
}

resource "openstack_containerinfra_clustertemplate_v1" "clustertemplate_1" {
  name                  = "${var.cluster_name}-template"
  image                 = "${module.image_datasource.image_id}"
  coe                   = "kubernetes"
  master_flavor         = "${module.master_flavor.flavor_id}"
  flavor                = "${module.flavor.flavor_id}"
  dns_nameserver        = "188.93.17.19,188.93.16.19,109.234.159.91"
  docker_storage_driver = "devicemapper"
  docker_volume_size    = "${var.cluster_docker_volume_size}"
  volume_driver         = "cinder"
  network_driver        = "flannel"
  server_type           = "vm"
  master_lb_enabled     = "${var.cluster_master_lb_enabled}"
  floating_ip_enabled   = false
  external_network_id   = "${data.openstack_networking_network_v2.external_net.id}"

  labels = {
    kube_tag                         = "${var.cluster_kube_version}"
    kube_dashboard_enabled           = "${var.cluster_kube_dashboard_enabled}"
    prometheus_monitoring            = "${var.cluster_prometheus_monitoring}"
    influx_grafana_dashboard_enabled = "${var.cluster_influx_grafana_dashboard_enabled}"
    etcd_volume_size                 = "${var.cluster_etcd_volume_size}"
    docker_volume_type               = "fast.${var.cluster_zone}"
    availability_zone                = "${var.cluster_zone}"
    flannel_backend                  = "host-gw"
    master_floating_ip               = "${var.cluster_master_floating_ip}"
  }
}

resource "openstack_containerinfra_cluster_v1" "cluster_1" {
  name                = "${var.cluster_name}"
  cluster_template_id = "${openstack_containerinfra_clustertemplate_v1.clustertemplate_1.id}"
  keypair             = "${module.keypair.keypair_name}"
  master_count        = "${var.cluster_master_count}"
  node_count          = "${var.cluster_node_count}"
}
