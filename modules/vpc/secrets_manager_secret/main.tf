resource "selectel_secretsmanager_secret_v1" "secret_1" {
  key         = "secret"
  value       = var.secret_value
  project_id  = var.project_id
  description = "secret from .tf"
}
