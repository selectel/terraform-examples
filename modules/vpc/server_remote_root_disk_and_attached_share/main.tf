# Создание SSH-ключа
resource "openstack_compute_keypair_v2" "key_tf" {
  name       = "${var.base_name}_keypair"
  region     = var.server_region
  public_key = file("${var.ssh_key_path}.pub")
}

# Запрос ID внешней сети по имени
data "openstack_networking_network_v2" "external_net" {
  name = "external-network"
}

# Создание роутера
resource "openstack_networking_router_v2" "router_tf" {
  name                = "${var.base_name}_router"
  external_network_id = data.openstack_networking_network_v2.external_net.id
}

# Создание сети
resource "openstack_networking_network_v2" "network_tf" {
  name = "${var.base_name}_network"
}

# Создание подсети
resource "openstack_networking_subnet_v2" "subnet_tf" {
  network_id = openstack_networking_network_v2.network_tf.id
  name       = "${var.base_name}_subnet"
  cidr       = var.subnet_cidr
}

# Создание порта для сервера
resource "openstack_networking_port_v2" "port_tf" {
  network_id     = openstack_networking_network_v2.network_tf.id
  name           = "${var.base_name}_port"
  admin_state_up = "true"
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet_tf.id
  }
}

# Подключение роутера к подсети
resource "openstack_networking_router_interface_v2" "router_interface_tf" {
  router_id = openstack_networking_router_v2.router_tf.id
  subnet_id = openstack_networking_subnet_v2.subnet_tf.id
}

# Поиск ID образа (из которого будет создан сервер) по его имени
data "openstack_images_image_v2" "ubuntu_image" {
  most_recent = true
  visibility  = "public"
  name        = var.server_image_name
}

# Создание сетевого загрузочного диска из образа
resource "openstack_blockstorage_volume_v3" "volume_server" {
  name                 = "${var.base_name}_volume"
  size                 = var.server_volume_size
  image_id             = data.openstack_images_image_v2.ubuntu_image.id
  volume_type          = var.server_volume_type
  availability_zone    = var.server_zone
  enable_online_resize = true
  lifecycle {
    ignore_changes = [image_id]
  }
}

# Создание сервера
resource "openstack_compute_instance_v2" "server_tf" {
  name              = "${var.base_name}_server"
  flavor_id         = var.flavor_id
  key_pair          = openstack_compute_keypair_v2.key_tf.id
  availability_zone = var.server_zone
  network {
    port = openstack_networking_port_v2.port_tf.id
  }
  block_device {
    uuid             = openstack_blockstorage_volume_v3.volume_server.id
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 0
  }
  vendor_options {
    ignore_resize_confirmation = true
  }
  lifecycle {
    ignore_changes = [image_id]
  }
  depends_on = [
    module.share
  ]
}

# Создание плавающего адреса
resource "openstack_networking_floatingip_v2" "fip_tf" {
  pool = "external-network"
}

# Привязка плавающего адреса к серверу
resource "openstack_networking_floatingip_associate_v2" "fip_tf" {
  floating_ip = openstack_networking_floatingip_v2.fip_tf.address
  port_id     = openstack_networking_port_v2.port_tf.id

  provisioner "remote-exec" {
    connection {
      host        = openstack_networking_floatingip_v2.fip_tf.address
      user        = var.ssh_user
      private_key = file(var.ssh_key_path)
    }

    inline = [
      "echo INSTALLING DEPENDENCIES...",
      "apt update && apt -y install nfs-common cifs-utils",
      "echo MOUNTING SHARE...",
      "export SHARE_PROTO=${module.share.share_proto}",
      "export SHARE_PATH=${module.share.share_export_location_path}",
      "mkdir -p /mnt/$SHARE_PROTO",
      "if [ \"$SHARE_PROTO\" = \"NFS\" ]; then echo \"mount -vt nfs $SHARE_PATH /mnt/$SHARE_PROTO -o rsize=1048576,wsize=1048576\"; fi",
      "if [ \"$SHARE_PROTO\" = \"NFS\" ]; then sudo mount -vt nfs $SHARE_PATH /mnt/$SHARE_PROTO -o rsize=1048576,wsize=1048576; fi",
      "if [ \"$SHARE_PROTO\" = \"CIFS\" ]; then echo \"mount.cifs $SHARE_PATH /mnt/$SHARE_PROTO -o pass=\"; fi",
      "if [ \"$SHARE_PROTO\" = \"CIFS\" ]; then sudo mount.cifs $SHARE_PATH /mnt/$SHARE_PROTO -o pass=; fi",
    ]
  }
}

# Создание NFS server_remote_root_disk_and_attached_share
module "share" {
  source = "../share"

  neutron_net_id = openstack_networking_network_v2.network_tf.id
  neutron_subnet_id = openstack_networking_subnet_v2.subnet_tf.id

  base_name = var.base_name
  share_size = var.share_size
  share_type = var.share_type
  share_proto = var.share_proto
  share_allowed_ip = var.share_allowed_ip
}
