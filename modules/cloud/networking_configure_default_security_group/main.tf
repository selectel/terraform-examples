
data "openstack_networking_secgroup_v2" "default_sg" {
  name = var.default_sg_name
  tenant_id = var.project_id
}

# Allow incoming HTTPS connections from anywhere
resource "openstack_networking_secgroup_rule_v2" "https_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = data.openstack_networking_secgroup_v2.default_sg.id
}
