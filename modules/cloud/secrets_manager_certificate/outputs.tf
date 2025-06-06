output "tls_container_ref" {
  value = selectel_secretsmanager_certificate_v1.certificate_1.id
}
