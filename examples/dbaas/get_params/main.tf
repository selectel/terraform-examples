###################
# Init Terraform
###################

terraform {
  required_providers {
    selectel = {
      source  = "selectel/selectel"
      version = "~> 9.3.0"
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

################################################
# Получение списка доступных баз данных и версия
################################################

data "selectel_dbaas_datastore_type_v1" "dt" {
  project_id = var.project_id
  region     = var.region

}

##########################################
# Получение списка готовых флаворов
##########################################
data "selectel_dbaas_flavor_v1" "flavors" {
  project_id = var.project_id
  region     = var.region
}

##########################################
# Получение доступных расширений Postgres
##########################################

data "selectel_dbaas_available_extension_v1" "pg_extensions" {
  project_id = var.project_id
  region     = var.region
}

#########################################################
# Каталог настроек пользователя PostgreSQL (по типу кластера)
#########################################################

data "selectel_dbaas_datastore_type_v1" "postgresql" {
  project_id = var.project_id
  region     = var.region
  filter {
    engine  = "postgresql"
    version = "17"
  }
}

data "selectel_dbaas_user_setting_parameter_v1" "user_setting_parameters" {
  project_id = var.project_id
  region     = var.region
  filter {
    datastore_type_id = data.selectel_dbaas_datastore_type_v1.postgresql.datastore_types[0].id
  }
}

#########################################################
# Каталог предопределённых ролей пользователя PostgreSQL
#########################################################

data "selectel_dbaas_roles_v1" "user_roles" {
  project_id = var.project_id
  region     = var.region

  filter {
    datastore_type_id = data.selectel_dbaas_datastore_type_v1.postgresql.datastore_types[0].id
  }
}
