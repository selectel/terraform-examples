resource "random_string" "random_name" {
  length  = 5
  special = false
}

# Создание сетевой инфраструктуры
data "openstack_networking_network_v2" "network" {
    external = true
}

resource "openstack_networking_router_v2" "router_1" {
  name                = "router"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.network.id
}

resource "openstack_networking_network_v2" "protected_network" {
  name           = "protected_network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "protected_subnet" {
  name       = "protected_subnet"
  network_id = openstack_networking_network_v2.protected_network.id
  cidr       = "192.168.199.0/24"
  ip_version = 4
}

resource "openstack_networking_router_interface_v2" "protected_router_interface" {
  router_id = openstack_networking_router_v2.router_1.id
  subnet_id = openstack_networking_subnet_v2.protected_subnet.id
}

resource "openstack_networking_network_v2" "unprotected_network" {
  name           = "unprotected_network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "unprotected_subnet" {
  network_id = openstack_networking_network_v2.unprotected_network.id
  cidr       = "10.20.30.0/24"
  ip_version = 4
}

resource "openstack_networking_router_interface_v2" "unprotected_router_interface" {
  router_id = openstack_networking_router_v2.router_1.id
  subnet_id = openstack_networking_subnet_v2.unprotected_subnet.id
}

# Создание файервола
resource "openstack_fw_rule_v2" "rule_1" {
  name                   = "allow_protected_network_traffic_rule"
  action                 = "allow"
  protocol               = "icmp"
}

resource "openstack_fw_rule_v2" "rule_2" {
  name                   = "allow_protected_network_traffic_rule"
  action                 = "allow"
  protocol               = "tcp"
  source_ip_address      = "192.168.199.0/24"
  destination_ip_address = "10.20.30.0/24"
}

resource "openstack_fw_policy_v2" "ingress_firewall_policy" {
  name        = "ingress_firewall_policy"
  description = ""
  audited     = true
  rules       = [
    openstack_fw_rule_v2.rule_1.id,
  ]
}

resource "openstack_fw_policy_v2" "egress_firewall_policy" {
  name        = "egress_firewall_policy"
  description = ""
  audited     = true
  rules       = [
    openstack_fw_rule_v2.rule_2.id,
  ]
}

resource "openstack_fw_group_v2" "group_1" {
  name                       = "terraform_group"
  admin_state_up             = true
  ingress_firewall_policy_id = openstack_fw_policy_v2.ingress_firewall_policy.id
  egress_firewall_policy_id  = openstack_fw_policy_v2.egress_firewall_policy.id
  ports                      = [
    openstack_networking_router_interface_v2.protected_router_interface.port_id,
  ]
}


# Создание сервера в закрытой файерволом сети
module "keypair" {
  source             = "../keypair"
  keypair_name       = "keypair-${random_string.random_name.result}"
  keypair_public_key = var.server_ssh_key
  keypair_user_id    = var.server_ssh_key_user
}

resource "openstack_blockstorage_volume_v3" "volume_1" {
  name              = "volume-for-${var.server_name}"
  size              = var.server_root_disk_gb
  image_id          = module.image_datasource.image_id
  volume_type       = var.server_volume_type
  availability_zone = var.server_zone

  lifecycle {
    ignore_changes = [image_id]
  }
}

module "image_datasource" {
  source     = "../image_datasource"
  image_name = var.server_image_name
}

resource "openstack_compute_instance_v2" "protected_instance" {
  name              = "protected_instance"
  flavor_id         = var.server_flavor_id
  key_pair          = module.keypair.keypair_name
  availability_zone = var.server_zone

  network {
    uuid = openstack_networking_network_v2.protected_network.id
    fixed_ip_v4 = "192.168.199.37"
  }

  block_device {
    uuid             = openstack_blockstorage_volume_v3.volume_1.id
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 0
  }

  lifecycle {
    ignore_changes = [image_id]
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}

# Создание сервера в открытой сети
resource "openstack_blockstorage_volume_v3" "volume_2" {
  name              = "volume-for-${var.server_name}"
  size              = var.server_root_disk_gb
  image_id          = module.image_datasource.image_id
  volume_type       = var.server_volume_type
  availability_zone = var.server_zone

  lifecycle {
    ignore_changes = [image_id]
  }
}

resource "openstack_compute_instance_v2" "unprotected_instance" {
  name              = "unprotected_instance"
  flavor_id         = 1011
  key_pair          = module.keypair.keypair_name
  availability_zone = var.server_zone

  network {
    uuid = openstack_networking_network_v2.unprotected_network.id
    fixed_ip_v4 = "10.20.30.37"
  }

  block_device {
    uuid             = openstack_blockstorage_volume_v3.volume_2.id
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 0
  }

  lifecycle {
    ignore_changes = [image_id]
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}
