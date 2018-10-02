resource "openstack_containerinfra_cluster_v1" "cluster_1" {
  name                 = "${var.cluster_name}"
  cluster_template_id  = "${var.cluster_template_id}"
  keypair              = "${var.cluster_keypair}"
  master_flavor        = "${var.cluster_master_flavor}"
  flavor               = "${var.cluster_flavor}"
  master_count         = "${var.cluster_master_count}"
  node_count           = "${var.cluster_node_count}"
}
