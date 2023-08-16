# Initialize Selectel provider with service user credentials.
provider "selectel" {
  username    = var.username
  password    = var.password
  domain_name = var.domain_name
}

module "project" {
  source = "../../../modules/vpc/project"

  project_name = var.project_name
}

data "selectel_mks_kube_versions_v1" "versions" {
  project_id = module.project.project_id
  region     = var.region
}

module "kubernetes_cluster" {
  source = "../../../modules/mks/cluster"

  cluster_name                      = var.cluster_name
  project_id                        = module.project.project_id
  region                            = var.region
  kube_version                      = data.selectel_mks_kube_versions_v1.versions.default_version
  enable_autorepair                 = var.enable_autorepair
  enable_patch_version_auto_upgrade = var.enable_patch_version_auto_upgrade
  network_id                        = var.network_id
  subnet_id                         = var.subnet_id
  maintenance_window_start          = var.maintenance_window_start
}

module "kubernetes_nodegroup" {
  source = "../../../modules/mks/nodegroup"

  cluster_id        = module.kubernetes_cluster.cluster_id
  project_id        = module.kubernetes_cluster.project_id
  region            = module.kubernetes_cluster.region
  availability_zone = var.availability_zone
  nodes_count       = var.nodes_count
  keypair_name      = var.keypair_name
  affinity_policy   = var.affinity_policy
  cpus              = var.cpus
  ram_mb            = var.ram_mb
  volume_gb         = var.volume_gb
  volume_type       = var.volume_type
  labels            = var.labels
  taints            = var.taints
}
