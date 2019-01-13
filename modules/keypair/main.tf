resource "selvpc_resell_keypair_v2" "keypair_1" {
  name       = "${var.keypair_name}"
  public_key = "${var.keypair_public_key}"
  user_id    = "${var.keypair_user_id}"
}
