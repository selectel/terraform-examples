###################
# Init Terraform
###################

terraform {
  required_providers {
    selectel = {
      source  = "selectel/selectel"
      version = "~> 3.6.2"
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
    engine  = "mysql"
    version = "8"
  }
}

###############################
# Поиск флавора
###############################

data "selectel_dbaas_flavor_v1" "flavor" {
  project_id = var.project_id
  region     = var.region
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
  node_count = 1
  flavor_id  = data.selectel_dbaas_flavor_v1.flavor.flavors[0].id
}

# ###############################
# # Создание пользователя БД
# ###############################

resource "selectel_dbaas_user_v1" "user_1" {
  project_id   = var.project_id
  region       = var.region
  datastore_id = selectel_dbaas_datastore_v1.datastore_1.id
  name         = "user"
  password     = "secret"
}

# ####################################
# # Создание Базы Данных
# ####################################

resource "selectel_dbaas_database_v1" "database_1" {
  project_id   = var.project_id
  region       = var.region
  datastore_id = selectel_dbaas_datastore_v1.datastore_1.id
  name         = "db"
}

####################################
# "Привязка" пользователя к базе
####################################

resource "selectel_dbaas_grant_v1" "grant_user1_db1" {
  project_id   = var.project_id
  region       = var.region
  datastore_id = selectel_dbaas_datastore_v1.datastore_1.id
  database_id  = selectel_dbaas_database_v1.database_1.id
  user_id      = selectel_dbaas_user_v1.user_1.id
}
