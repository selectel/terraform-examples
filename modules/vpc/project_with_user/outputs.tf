output "project_id" {
  value = module.project.project_id
}

output "user_id" {
  value = selectel_iam_serviceuser_v1.serviceuser_1.id
}
