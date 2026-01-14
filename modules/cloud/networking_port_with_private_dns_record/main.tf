resource "selectel_private_dns_zone_v1" "zone_1" {
  region = var.region
  project_id = var.project_id
  domain = var.zone_domain
}

resource "openstack_networking_network_v2" "network_1" {
  name = var.network_name
  tenant_id = var.project_id
  dns_domain = var.zone_domain
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  network_id = openstack_networking_network_v2.network_1.id
  name = var.subnet_cidr
  cidr = var.subnet_cidr
}

resource "openstack_networking_port_v2" "port_1" {
  network_id = openstack_networking_network_v2.network_1.id
  name = var.port_hostname
  dns_name = var.port_hostname

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet_1.id
  }
}
