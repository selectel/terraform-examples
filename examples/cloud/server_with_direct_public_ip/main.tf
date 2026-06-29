provider "selectel" {
  username    = var.username
  password    = var.password
  domain_name = var.domain_name
  auth_region = var.region
  auth_url    = var.auth_url
}

module "project_with_user" {
  providers = {
    selectel = selectel,
  }
  source = "../../../modules/cloud/project_with_user"

  project_name      = var.project_name
  project_user_name = var.project_user_name
  user_password     = var.user_password
}

provider "openstack" {
  user_name           = var.project_user_name
  tenant_name         = var.project_name
  password            = var.user_password
  project_domain_name = var.domain_name
  user_domain_name    = var.domain_name
  auth_url            = var.auth_url
  region              = var.region
}

resource "openstack_networking_secgroup_v2" "secgroup_1" {
  name        = "tf_public_port_sg"
  description = "Security group for public port"
}

resource "openstack_networking_secgroup_rule_v2" "ssh_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "icmp_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "selectel_vpc_public_port_v1" "public_port_1" {
  region       = var.region
  project_id   = module.project_with_user.project_id
  description  = "Public port for ${var.server_name}"

  security_group_ids = [
    openstack_networking_secgroup_v2.secgroup_1.id,
  ]

  depends_on = [
    module.project_with_user,
  ]
}

resource "random_string" "random_name" {
  length  = 5
  special = false
}

module "flavor" {
  source               = "../../../modules/cloud/flavor"
  flavor_name          = "flavor-${random_string.random_name.result}"
  flavor_vcpus         = var.server_vcpus
  flavor_ram_mb        = var.server_ram_mb
  flavor_local_disk_gb = var.server_root_disk_gb
}

module "image_datasource" {
  source     = "../../../modules/cloud/image_datasource"
  image_name = var.server_image_name
}

module "keypair" {
  source             = "../../../modules/cloud/keypair"
  keypair_name       = "keypair-${random_string.random_name.result}"
  keypair_public_key = file(pathexpand(var.keypair_path))
  keypair_user_id    = module.project_with_user.user_id
}

resource "openstack_compute_instance_v2" "instance_1" {
  name              = var.server_name
  image_id          = module.image_datasource.image_id
  flavor_id         = module.flavor.flavor_id
  key_pair          = module.keypair.keypair_name
  availability_zone = var.server_zone

  lifecycle {
    ignore_changes = [image_id, availability_zone]
  }

  vendor_options {
    ignore_resize_confirmation = true
  }

  depends_on = [
    module.project_with_user,
  ]
}

resource "openstack_compute_interface_attach_v2" "attach" {
  instance_id = openstack_compute_instance_v2.instance_1.id
  port_id     = data.selectel_vpc_public_port_v1.port_1.id
}
