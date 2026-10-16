# Пример создания кластера Postgres

Создание Кластера Postgres 17 в уже существующей сети с тремя нодами и с произвольной конфигурацией нод.  
Для работы с существующими сетями будет использоваться провайдер `openstack`. Кластер будет создан в сети с именем *nat* - задаётся в vars.tf.

При создании пользователь получает настройки и роли.

Настройки задаются аргументом `settings` — картой «имя параметра → значение». Значения передаются строками и приводятся к нужному типу автоматически. В примере перечислены все параметры из каталога для PostgreSQL 17; каталог параметров для нужного типа кластера можно получить data source-ом `selectel_dbaas_user_setting_parameter_v1` с фильтром `datastore_id` или `datastore_type_id` — как в примере `get_params`. Ключ, убранный из `settings`, сбрасывается к значению по умолчанию из каталога. Аргумент `settings` доступен для кластеров PostgreSQL, 1C и TimescaleDB; в примерах MySQL и Redis его нет.

Роли задаются аргументом `roles` — списком ID предопределённых ролей. ID и имена доступных ролей можно получить data source-ом `selectel_dbaas_roles_v1` с фильтром `datastore_type_id`. Роль, убранная из `roles`, отзывается, новая — выдаётся.

Нужен провайдер Selectel версии 9.3.0 или новее (`~> 9.3.0`) — в этой версии у `selectel_dbaas_user_v1` появились аргументы `settings` и `roles`, а также data sources `selectel_dbaas_user_setting_parameter_v1` и `selectel_dbaas_roles_v1`.

# Запуск

## Подготовка

```bash
cp vars.tfvars.example vars.tfvars

# Далее нужно отредактировать vars.tfvars
vim vars.tfvars
```

```ini
# Сервисный пользователь, https://my.selectel.ru/profile/users_management/users
username="USER"
password="PASSWORD"
# ID аккаунта
domain_name="ACCOUNT_ID"
# ID проекта Облачной Платформы
project_id="PROJECT_ID"
# Регион проекта Облачной Платформы
region="REGION"
```

## Создание кластера
```bash
# Инициализация терраформ-окружения
terraform init
# Просмотр предложенных операций
terraform plan --var-file="vars.tfvars"
# Применение манифеста
terraform apply --var-file="vars.tfvars"
```

## Output-переменные
```bash
$ terraform output
cluster_id = "5579a1f3-12ab-4b6a-b926-49eb861feaa1"
cluster_status = "ACTIVE"
db_name = "db"
db_user = "user"
db_user_password = "secret"
db_user_settings = {
  "bypassrls"                           = "false"
  "conn_limit"                          = "20"
  "default_transaction_isolation"       = "read committed"
  "default_transaction_read_only"       = "false"
  "idle_in_transaction_session_timeout" = "60000"
  "lock_timeout"                        = "1000"
  "log_min_duration_statement"          = "-1"
  "log_statement"                       = "none"
  "login"                               = "true"
  "statement_timeout"                   = "5000"
  "synchronous_commit"                  = "on"
  "temp_file_limit"                     = "-1"
  "work_mem"                            = "4096"
}
db_user_roles = tolist([
  "123e4567-e89b-12d3-a456-426614174000",
  "123e4567-e89b-12d3-a456-426614174001",
])
master_host = "master.5579a1f3-12ab-4b6a-b926-49eb861feaa1.c.dbaas.selcloud.ru"
```

## Удаление стенда
```bash
terraform destroy --var-file="vars.tfvars"
```
