### ROUTERS SECTION
data "openstack_networking_network_v2" "external_net" {
  name = var.router_external_net_name
}

resource "openstack_networking_router_v2" "main_router" {
  name                = "main_router"
  external_network_id = data.openstack_networking_network_v2.external_net.id
}

resource "openstack_networking_router_v2" "secondary_router" {
  name                = "secondary_router"
  external_network_id = data.openstack_networking_network_v2.external_net.id
}

### NETWORKS SECTION
resource "openstack_networking_network_v2" "network_one" {
  name = "network_one"
}

resource "openstack_networking_network_v2" "network_two" {
  name = "network_two"
}

### SUBNETS SECTION
resource "openstack_networking_subnet_v2" "subnet_one" {
  network_id      = openstack_networking_network_v2.network_one.id
  name            = "10.10.0.0/24"
  cidr            = "10.10.0.0/24"
  enable_dhcp     = false
  dns_nameservers = ["188.93.16.19", "188.93.17.19"]
}

resource "openstack_networking_subnet_v2" "subnet_two" {
  network_id      = openstack_networking_network_v2.network_one.id
  name            = "10.20.0.0/24"
  cidr            = "10.20.0.0/24"
  enable_dhcp     = false
  dns_nameservers = ["188.93.16.19", "188.93.17.19"]
}

resource "openstack_networking_subnet_v2" "subnet_three" {
  network_id      = openstack_networking_network_v2.network_two.id
  name            = "10.30.0.0/24"
  cidr            = "10.30.0.0/24"
  enable_dhcp     = false
  dns_nameservers = ["188.93.16.19", "188.93.17.19"]
}

### SUBNETS PORTS SECTION
resource "openstack_networking_port_v2" "subnet_one_main_router_port" {
  name       = "subnet_one_main_router_port"
  network_id = openstack_networking_network_v2.network_one.id

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet_one.id
    ip_address = "10.10.0.1"
  }
}

resource "openstack_networking_port_v2" "subnet_one_secondary_router_port" {
  name       = "subnet_one_secondary_router_port"
  network_id = openstack_networking_network_v2.network_one.id

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet_one.id
    ip_address = "10.10.0.2"
  }
}

resource "openstack_networking_port_v2" "subnet_two_secondary_router_port" {
  name       = "subnet_two_secondary_router_port"
  network_id = openstack_networking_network_v2.network_one.id

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet_two.id
    ip_address = "10.20.0.1"
  }
}

### ROUTER'S ATTACHMENTS SUBNETS SECTION
resource "openstack_networking_router_interface_v2" "main_router_interface_one" {
  router_id = openstack_networking_router_v2.main_router.id
  port_id   = openstack_networking_port_v2.subnet_one_main_router_port.id
}

resource "openstack_networking_router_interface_v2" "secondary_router_interface_one" {
  router_id = openstack_networking_router_v2.secondary_router.id
  port_id   = openstack_networking_port_v2.subnet_one_secondary_router_port.id
}

resource "openstack_networking_router_interface_v2" "secondary_router_interface_two" {
  router_id = openstack_networking_router_v2.secondary_router.id
  port_id   = openstack_networking_port_v2.subnet_two_secondary_router_port.id
}

### PORTS SECTION
resource "openstack_networking_port_v2" "main_server_subnet_one_port" {
  name       = "main_server_subnet_one_port"
  network_id = openstack_networking_network_v2.network_one.id

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet_one.id
    ip_address = "10.10.0.10"
  }
}

resource "openstack_networking_port_v2" "main_server_subnet_three_port" {
  name       = "main_server_subnet_three_port"
  network_id = openstack_networking_network_v2.network_two.id

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet_three.id
    ip_address = "10.30.0.10"
  }
}

resource "openstack_networking_port_v2" "server_with_docker_subnet_two_port" {
  name       = "server_with_docker_subnet_two_port"
  network_id = openstack_networking_network_v2.network_one.id

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet_two.id
    ip_address = "10.20.0.20"
  }
}

resource "openstack_networking_port_v2" "proxy_server_subnet_three_port" {
  name       = "proxy_server_subnet_three_port"
  network_id = openstack_networking_network_v2.network_two.id

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet_three.id
    ip_address = "10.30.0.30"
  }
}

resource "openstack_networking_port_v2" "proxy_server_public_subnet_port" {
  name       = "proxy_server_public_subnet_port"
  network_id = var.selvpc_network_id

  fixed_ip {
    subnet_id = var.selvpc_subnet_id
  }
}

### ROUTES SECTION
resource "openstack_networking_router_route_v2" "secondary_router_route_to_docker" {
  depends_on = [
    openstack_networking_router_interface_v2.secondary_router_interface_one,
  ]
  router_id        = openstack_networking_router_v2.secondary_router.id
  destination_cidr = "172.17.0.0/24"
  next_hop         = "10.20.0.20"
}

resource "openstack_networking_subnet_route_v2" "subnet_one_eights_route_via_secondary_router" {
  depends_on = [
    openstack_networking_subnet_v2.subnet_one,
  ]
  subnet_id        = openstack_networking_subnet_v2.subnet_one.id
  destination_cidr = "8.0.0.0/8"
  next_hop         = "10.10.0.2"
}

resource "openstack_networking_subnet_route_v2" "subnet_one_docker_route_via_secondary_router" {
  depends_on = [
    openstack_networking_subnet_v2.subnet_one,
  ]
  subnet_id        = openstack_networking_subnet_v2.subnet_one.id
  destination_cidr = "172.17.0.0/24"
  next_hop         = "10.10.0.2"
}

resource "openstack_networking_subnet_route_v2" "subnet_one_route_to_subnet_to_via_secondary_router" {
  depends_on = [
    openstack_networking_subnet_v2.subnet_one,
  ]
  subnet_id        = openstack_networking_subnet_v2.subnet_one.id
  destination_cidr = "10.20.0.0/24"
  next_hop         = "10.10.0.2"
}

resource "openstack_networking_subnet_route_v2" "subnet_three_route_to_public_subnet" {
  depends_on = [
    openstack_networking_subnet_v2.subnet_three,
  ]
  subnet_id        = openstack_networking_subnet_v2.subnet_three.id
  destination_cidr = var.selvpc_subnet_cidr
  next_hop         = "10.30.0.30"
}

resource "openstack_networking_subnet_route_v2" "subnet_three_route_to_nines_via_public_subnet" {
  subnet_id        = openstack_networking_subnet_v2.subnet_three.id
  destination_cidr = "9.0.0.0/8"
  next_hop         = "10.30.0.30"
}
