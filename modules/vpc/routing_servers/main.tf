### COMMON MODULES
module "image_datasource" {
  source     = "../image_datasource"
  image_name = var.server_image_name
}

### MAIN SERVER
resource "openstack_blockstorage_volume_v3" "main_server_volume" {
  name              = "main_server_volume"
  size              = 5
  image_id          = module.image_datasource.image_id
  volume_type       = "fast.${var.target_zone}"
  availability_zone = var.target_zone

  lifecycle {
    ignore_changes = [image_id]
  }
}

resource "openstack_compute_instance_v2" "main_server" {
  name              = "main_server"
  flavor_id         = 1011
  key_pair          = var.keypair_name
  availability_zone = var.target_zone

  network {
    port = var.main_server_subnet_one_port_id
  }

  network {
    port = var.main_server_subnet_three_port_id
  }

  block_device {
    uuid             = openstack_blockstorage_volume_v3.main_server_volume.id
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 0
  }

  metadata = {
    x_sel_server_default_addr = "{\"ipv4\":\"${var.main_server_subnet_one_port_ip}\"}"
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}

### SERVER WITH DOCKER
resource "openstack_blockstorage_volume_v3" "server_with_docker_volume" {
  name              = "server_with_docker_volume"
  size              = 5
  image_id          = module.image_datasource.image_id
  volume_type       = "fast.${var.target_zone}"
  availability_zone = var.target_zone

  lifecycle {
    ignore_changes = [image_id]
  }
}

resource "openstack_compute_instance_v2" "server_with_docker" {
  name              = "server_with_docker"
  flavor_id         = 1011
  key_pair          = var.keypair_name
  availability_zone = var.target_zone

  network {
    port = var.server_with_docker_subnet_two_port_id
  }

  block_device {
    uuid             = openstack_blockstorage_volume_v3.server_with_docker_volume.id
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 0
  }

  metadata = {
    x_sel_server_default_addr = "{\"ipv4\":\"${var.server_with_docker_subnet_two_port_ip}\"}"
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}

### PROXY SERVER WITH PUBLIC SUBNET
resource "openstack_blockstorage_volume_v3" "proxy_server_volume" {
  name              = "proxy_server_volume"
  size              = 5
  image_id          = module.image_datasource.image_id
  volume_type       = "fast.${var.target_zone}"
  availability_zone = var.target_zone

  lifecycle {
    ignore_changes = [image_id]
  }
}

resource "openstack_compute_instance_v2" "proxy_server" {
  name              = "proxy_server"
  flavor_id         = 1011
  key_pair          = var.keypair_name
  availability_zone = var.target_zone

  network {
    port = var.proxy_server_public_subnet_port_id
  }

  network {
    port = var.proxy_server_subnet_three_port_id
  }

  block_device {
    uuid             = openstack_blockstorage_volume_v3.proxy_server_volume.id
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 0
  }

  metadata = {
    x_sel_server_default_addr = "{\"ipv4\":\"${var.proxy_server_public_subnet_port_ip}\"}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf",
      "sysctl net.ipv4.ip_forward=1",
    ]
    connection {
      type        = "ssh"
      user        = "root"
      host        = var.proxy_server_public_subnet_port_ip
      private_key = file("~/.ssh/id_rsa")
    }
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}
