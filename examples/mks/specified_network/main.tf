# Initialize Selectel provider with token.
provider "selectel" {
  token = var.sel_token
}

# Initialize Openstack provider
provider "openstack" {
  user_name           = var.user_name
  tenant_name         = var.project_name
  password            = var.user_password
  project_domain_name = var.sel_account
  user_domain_name    = var.sel_account
  auth_url            = var.os_auth_url
  region              = var.os_region
}

# Create the main project with user.
# This module should be applied first.
module "project_with_user" {
  source = "../../../modules/vpc/project_with_user"

  project_name  = var.project_name
  user_name     = var.user_name
  user_password = var.user_password
}

# Create a network
module "nat" {
  source = "../../../modules/vpc/nat"
}

# Create a k8s cluster
module "kubernetes_cluster" {
  source = "../../../modules/mks/cluster"

  cluster_name                      = var.cluster_name
  project_id                        = module.project_with_user.project_id
  region                            = var.region
  kube_version                      = var.kube_version
  enable_autorepair                 = var.enable_autorepair
  enable_patch_version_auto_upgrade = var.enable_patch_version_auto_upgrade
  network_id                        = module.nat.network_id
  subnet_id                         = module.nat.subnet_id
  maintenance_window_start          = var.maintenance_window_start
}

# Create a node group
module "kubernetes_nodegroup" {
  source = "../../../modules/mks/nodegroup"

  cluster_id        = module.kubernetes_cluster.cluster_id
  project_id        = module.kubernetes_cluster.project_id
  region            = module.kubernetes_cluster.region
  availability_zone = var.availability_zone
  nodes_count       = var.nodes_count
  affinity_policy   = var.affinity_policy
  cpus              = var.cpus
  ram_mb            = var.ram_mb
  volume_gb         = var.volume_gb
  volume_type       = var.volume_type
}
