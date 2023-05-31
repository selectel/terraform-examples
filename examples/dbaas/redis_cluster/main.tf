###################
# Init Terraform
###################

terraform {
  required_providers {
    selectel = {
      source  = "selectel/selectel"
      version = "~> 3.8.4"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.42.0"
    }
  }
}

###############################
# Конфигурация Selectel Провайдера
###############################

provider "selectel" {
  token = var.sel_token
}

###############################
# Конфигурация Openstack Провайдера
###############################

provider "openstack" {
  user_name           = var.user_name
  password            = var.user_password
  tenant_id           = var.project_id
  project_domain_name = var.sel_account
  user_domain_name    = var.sel_account
  auth_url            = var.os_auth_url
  region              = var.region
}

###############################
# Поиск Network and Subnet
###############################

data "openstack_networking_network_v2" "my_net" {
  name = var.network_name
}

data "openstack_networking_subnet_v2" "my_subnet" {
  network_id = data.openstack_networking_network_v2.my_net.id
}

###############################
# Поиск datastore_type
###############################

data "selectel_dbaas_datastore_type_v1" "dt" {
  project_id = var.project_id
  region     = var.region
  filter {
    engine  = "redis"
    version = "6"
  }
}

###############################
# Поиск flavor
###############################

data "selectel_dbaas_flavor_v1" "flavor" {
    project_id = var.project_id
    region     = var.region
    filter {
        datastore_type_id = data.selectel_dbaas_datastore_type_v1.dt.datastore_types[0].id
    }
}

###############################
# Создание Кластера БД
###############################

resource "selectel_dbaas_datastore_v1" "datastore_1" {
  name       = "datastore-1"
  project_id = var.project_id
  region     = var.region
  type_id    = data.selectel_dbaas_datastore_type_v1.dt.datastore_types[0].id
  subnet_id  = data.openstack_networking_subnet_v2.my_subnet.id
  node_count = 2
  redis_password = var.redis_password
  flavor_id = data.selectel_dbaas_flavor_v1.flavor.flavors[0].id
  config = {
    maxmemory-policy = "noeviction"
  }
}
