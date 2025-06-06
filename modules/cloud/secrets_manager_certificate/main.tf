resource "selectel_secretsmanager_certificate_v1" "certificate_1" {
  name          = "certificate_from_terraform"
  certificates  = var.certificates_file
  private_key   = var.private_key_file
  project_id    = var.project_id
}
