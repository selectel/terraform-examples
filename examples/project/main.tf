# Generate random string that will be used as name for a project.
resource "random_string" "random_name" {
  length = 12

  special = false
  upper   = false
  number  = false
}

# Create a single SelVPC project.
module "project" {
  source = "../../modules/project"

  project_name = "${random_string.random_name.result}"
}
