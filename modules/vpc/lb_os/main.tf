# Create a network
module "nat" {
  source = "../nat"
}

# Create OpenStack Compute instances.
module "multiple_servers" {
  source = "../multiple_servers"

  replicas_count = var.count_of_servers

  # OpenStack Instance parameters.
  server_zone         = var.target_zone
  server_vcpus        = var.server_vcpus
  server_ram_mb       = var.server_ram_mb
  server_root_disk_gb = var.server_root_disk_gb
  server_image_name   = var.server_image_name
  keypair_name        = var.keypair_name

  server_network_id = module.nat.network_id
  server_subnet_id  = module.nat.subnet_id
}

# Create loadbalancer
module "lb_loadbalancer" {
  source = "../lb_loadbalancer"

  vip_subnet_id = module.nat.subnet_id
  lb_flavor_id  = var.lb_flavor_id
}

# Create HTTP or HTTPS listeners. pools, monitors and members
module "lb_components_http" {
  count  = length(var.lb_components_http)
  source = "../lb_components_http"

  lb_components     = var.lb_components_http["component_${count.index + 1}"]
  loadbalancer_id   = module.lb_loadbalancer.loadbalancer_id
  server_access_ips = module.multiple_servers.server_access_ips
}

# Create TCP or UDP listeners, pools, monitors and memebers
module "lb_components" {
  count  = length(var.lb_components)
  source = "../lb_components"

  lb_components     = var.lb_components["component_${count.index + 1}"]
  loadbalancer_id   = module.lb_loadbalancer.loadbalancer_id
  server_access_ips = module.multiple_servers.server_access_ips
}
