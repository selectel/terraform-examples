###################
# Init Terraform
###################

terraform {
  required_providers {
    selectel = {
      source  = "selectel/selectel"
      version = "~> 4.0.0-aplha"
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
  username    = var.username
  password    = var.password
  domain_name = var.domain_name
}

###############################
# Конфигурация Openstack Провайдера
###############################

provider "openstack" {
  user_name           = var.username
  password            = var.password
  tenant_id           = var.project_id
  project_domain_name = var.domain_name
  user_domain_name    = var.domain_name
  auth_url            = var.auth_url
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
