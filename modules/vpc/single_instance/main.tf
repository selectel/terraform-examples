# Получение сведений о конфигурации создаваемого инстанса
data "openstack_compute_flavor_v2" "flavor" {
  vcpus     = var.server_vcpus
  ram       = var.server_ram_mb
  disk      = var.server_root_disk_gb
  is_public = "true"
}

# Получение информации об образе ОС
module "image_datasource" {
  source     = "../image_datasource"
  image_name = var.server_image_name
}

# Создание сетевых портов
resource "openstack_networking_port_v2" "private_port" {
  name       = "${var.server_name}-eth0"
  network_id = var.private_network_id

  fixed_ip {
    subnet_id = var.private_subnet_id
  }
}

resource "openstack_networking_port_v2" "public_port" {
  name       = "${var.server_name}-eth1"
  network_id = var.public_network_id

  fixed_ip {
    subnet_id = var.public_subnet_id
  }
}

# Создание инстанса
resource "openstack_compute_instance_v2" "instance" {
  name              = var.server_name
  image_id          = module.image_datasource.image_id
  flavor_id         = data.openstack_compute_flavor_v2.flavor.id
  key_pair          = var.keypair_name
  availability_zone = var.server_zone
  user_data         = var.user_data

  network {
    port = openstack_networking_port_v2.private_port.id
  }

  network {
    port = openstack_networking_port_v2.public_port.id
  }

  lifecycle {
    ignore_changes = [image_id]
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}
