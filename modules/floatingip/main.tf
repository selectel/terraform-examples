resource "selvpc_resell_floatingip_v2" "floatingip_1" {
  project_id = "${var.floatingip_project_id}"
  region     = "${var.floatingip_region}"
}
