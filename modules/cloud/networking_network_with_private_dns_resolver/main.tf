
resource "openstack_networking_network_v2" "network_1" {
  name = var.network_name
  tenant_id = var.project_id
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  network_id = openstack_networking_network_v2.network_1.id
  name = var.subnet_cidr
  cidr = var.subnet_cidr
}

resource "selectel_private_dns_service_v1" "service_1" {
  region = var.region
  project_id = var.project_id
  network_id = openstack_networking_network_v2.network_1.id
}
