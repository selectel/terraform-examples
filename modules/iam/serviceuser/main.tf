resource "selectel_iam_serviceuser_v1" "serviceuser_1" {
  name     = var.user_name
  password = var.user_password
  
  dynamic "role" {
    for_each = var.roles[*]
    content {
      role_name  = lookup(role.value, "role_name")
      scope      = lookup(role.value, "scope")
      project_id = lookup(role.value, "project_id", null)
    }
    
  }
}