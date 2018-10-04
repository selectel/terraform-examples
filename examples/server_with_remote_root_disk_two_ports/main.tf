# Generate random string that will be used as name for all resources.
resource "random_string" "random_name" {
  length = 12

  special = false
  upper   = false
  number  = false
}

# Create OpenStack keypair with current public key.
module "keypair" {
  source = "../../modules/keypair"

  keypair_name       = "${random_string.random_name.result}-keypair"
  keypair_public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# Create OpenStack flavor without local disk.
module "flavor" {
  source = "../../modules/flavor"

  flavor_name          = "${random_string.random_name.result}-flavor"
  flavor_vcpus         = 4
  flavor_ram_mb        = 4096
  flavor_local_disk_gb = 0
}

# Search for the public image ID.
module "image_datasource" {
  source = "../../modules/image_datasource"

  image_name = "Ubuntu 16.04 LTS 64-bit"
}

# Create OpenStack Compute instance.
module "server_remote_root_disk_two_ports" {
  source = "../../modules/server_remote_root_disk_two_ports"

  server_name = "${random_string.random_name.result}-server"

  server_flavor_id         = "${module.flavor.flavor_id}"
  server_keypair_name      = "${module.keypair.keypair_id}"
  server_image_id          = "${module.image_datasource.image_id}"
  server_availability_zone = "ru-3a"

  server_volume_size_gb = 8
  server_volume_type    = "fast.ru-3a"
}

# Create single OpenStack Floating IP for the instance.
module "floatingip" {
  source = "../../modules/floatingip"
}

# Associate Floating IP with instance network interface.
resource "openstack_networking_floatingip_associate_v2" "association_1" {
  port_id     = "${module.server_remote_root_disk_two_ports.server_first_port_id}"
  floating_ip = "${module.floatingip.floatingip_address}"
}
