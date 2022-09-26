###################
# Init Terraform
###################

terraform {
  required_providers {
    selectel = {
      source  = "selectel/selectel"
      version = "~> 3.8.4"
    }
  }
}

###############################
# Конфигурация Selectel Провайдера
###############################

provider "selectel" {
  token = var.sel_token
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
