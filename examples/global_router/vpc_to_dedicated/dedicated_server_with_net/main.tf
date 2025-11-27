data "selectel_dedicated_configuration_v1" "server_config" {
  project_id  = var.project_id
  deep_filter = <<EOT
    {
       "name": "EL10-SSD"
    }
  EOT
}

data "selectel_dedicated_location_v1" "server_location" {
  project_id = var.project_id
  filter {
    name = var.region_name
  }
}

data "selectel_dedicated_os_v1" "server_os" {
  project_id = var.project_id
  filter {
    name             = "Ubuntu"
    version_value    = "2404"
    configuration_id = data.selectel_dedicated_configuration_v1.server_config.configurations[0].id
    location_id      = data.selectel_dedicated_location_v1.server_location.locations[0].id
  }
}

resource "selectel_dedicated_server_v1" "server_1" {
  project_id       = var.project_id
  configuration_id = data.selectel_dedicated_configuration_v1.server_config.configurations[0].id
  location_id      = data.selectel_dedicated_location_v1.server_location.locations[0].id
  os_id            = data.selectel_dedicated_os_v1.server_os.os[0].id
  price_plan_name  = var.price_plan_name
  private_subnet   = var.subnet_cidr1
}
