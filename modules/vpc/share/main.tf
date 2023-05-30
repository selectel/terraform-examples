resource "openstack_sharedfilesystem_sharenetwork_v2" "sharenetwork_1" {
  name = "${var.base_name}_sharenetwork"
  neutron_net_id = var.neutron_net_id
  neutron_subnet_id = var.neutron_subnet_id
}

resource "openstack_sharedfilesystem_share_v2" "share_1" {
  name             = "${var.base_name}_share"
  size             = var.share_size
  share_type       = var.share_type
  share_proto      = var.share_proto
  share_network_id = openstack_sharedfilesystem_sharenetwork_v2.sharenetwork_1.id
}

resource "openstack_sharedfilesystem_share_access_v2" "shareaccess_1" {
  access_level = "rw"
  access_to    = var.share_allowed_ip
  access_type  = "ip"
  share_id     = openstack_sharedfilesystem_share_v2.share_1.id
}
