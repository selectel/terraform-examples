###################
# Init Terraform
###################

terraform {
  required_providers {
    selectel = {
      source = "selectel/selectel"
      # settings/roles у selectel_dbaas_user_v1 и data sources
      # *_user_setting_parameter_v1 / *_roles_v1 появились в 9.3.0
      version = "~> 9.3.0"
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
    engine  = "postgresql"
    version = "17"
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
  node_count = 3
  flavor {
    vcpus = 4
    ram   = 4096
    disk  = 32
  }
  pooler {
    mode = "transaction"
    size = 50
  }
}

###############################
# Поиск ролей пользователя
###############################

data "selectel_dbaas_roles_v1" "user_roles" {
  project_id = var.project_id
  region     = var.region

  filter {
    datastore_type_id = data.selectel_dbaas_datastore_type_v1.dt.datastore_types[0].id
  }
}

locals {
  # Карта «имя роли → ID роли» для выбранного типа кластера.
  role_ids = {
    for role in data.selectel_dbaas_roles_v1.user_roles.roles : role.name => role.id
  }
}

###############################
# Создание пользователя БД
###############################

resource "selectel_dbaas_user_v1" "user_1" {
  project_id   = var.project_id
  region       = var.region
  datastore_id = selectel_dbaas_datastore_v1.datastore_1.id
  name         = "user"
  password     = "secret"

  # Настройки пользователя PostgreSQL.
  # Набор ключей зависит от типа кластера, каталог параметров можно получить
  # data source-ом selectel_dbaas_user_setting_parameter_v1 (см. пример get_params).
  # Значения передаются строками и приводятся к нужному типу автоматически.
  settings = {
    conn_limit                          = "20"
    login                               = "true"
    bypassrls                           = "false"
    statement_timeout                   = "5000"
    lock_timeout                        = "1000"
    idle_in_transaction_session_timeout = "60000"
    temp_file_limit                     = "-1"
    work_mem                            = "4096"
    log_min_duration_statement          = "-1"
    default_transaction_isolation       = "read committed"
    log_statement                       = "none"
    synchronous_commit                  = "on"
    default_transaction_read_only       = "false"
  }

  # Предопределённые роли пользователя PostgreSQL.
  # Доступные роли можно получить data source-ом selectel_dbaas_roles_v1.
  roles = [
    local.role_ids["pg_read_all_stats"],
    local.role_ids["pg_signal_backend"],
  ]
}

####################################
# Создание Базы Данных
####################################

resource "selectel_dbaas_database_v1" "database_1" {
  project_id   = var.project_id
  region       = var.region
  datastore_id = selectel_dbaas_datastore_v1.datastore_1.id
  owner_id     = selectel_dbaas_user_v1.user_1.id
  name         = "db"
  lc_ctype     = "ru_RU.utf8"
  lc_collate   = "ru_RU.utf8"
}

####################################
# Подключение расширения
####################################

data "selectel_dbaas_available_extension_v1" "ae" {
  project_id = var.project_id
  region     = var.region
  filter {
    name = "hstore"
  }
}

resource "selectel_dbaas_extension_v1" "extension_1" {
  project_id             = var.project_id
  region                 = var.region
  datastore_id           = selectel_dbaas_datastore_v1.datastore_1.id
  database_id            = selectel_dbaas_database_v1.database_1.id
  available_extension_id = data.selectel_dbaas_available_extension_v1.ae.available_extensions[0].id
}
