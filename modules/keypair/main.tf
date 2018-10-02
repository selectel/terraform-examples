resource "openstack_compute_keypair_v2" "keypair_1" {
  name       = "${var.keypair_name}"
  public_key = "${var.keypair_public_key}"
}
