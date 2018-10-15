# Generate random string that will be used as name for all resources.
resource "random_string" "random_name" {
  length  = 12
  special = false
  upper   = false
}

# Create OpenStack keypair with current public key.
module "keypair" {
  source = "../../modules/keypair"

  keypair_name       = "${random_string.random_name.result}"
  keypair_public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# Create OpenStack flavor without local disk.
module "flavor" {
  source = "../../modules/flavor"

  flavor_name          = "${random_string.random_name.result}"
  flavor_vcpus         = 2
  flavor_ram_mb        = 2048
  flavor_local_disk_gb = 0
}

# Find public Kubernetes cluster template.
module "kubernetes_cluster_template_datasource" {
  source = "../../modules/kubernetes_cluster_template_datasource"
}

# Create a single Kubernetes cluster.
module "kubernetes_cluster" {
  source = "../../modules/kubernetes_cluster"

  cluster_template_id   = "${module.kubernetes_cluster_template_datasource.cluster_template_id}"
  cluster_keypair       = "${module.keypair.keypair_id}"
  cluster_master_flavor = "${module.flavor.flavor_id}"
  cluster_flavor        = "${module.flavor.flavor_id}"
  cluster_master_count  = 3
  cluster_node_count    = 3
}
