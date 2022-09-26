# Пример создания кластера Postgres

Создание Кластера Redis 6 в уже существующей сети с двумя нодами и с фиксированной конфигурацией нод.
Для работы с существующими сетями будет использоваться провайдер `openstack`. Кластер будет создан в сети с именем *nat* - задаётся в vars.tf.

# Запуск

## Подготовка

```bash
cp vars.tfvars.example vars.tfvars

# Далее нужно отредактировать vars.tfvars
vim vars.tfvars
```

```ini
# ID в my.selectel.ru/номер договора
sel_account="SEL_ACCOUNT"
# Токен, https://my.selectel.ru/profile/apikeys
sel_token="SEL_TOKEN"

# ID проекта Облачной Платформы
project_id="PROJECT_ID"
# Регион проекта Облачной Платформы
region="REGION"
# Пользователь OpenStack, привязанный к проекту
user_name="USERNAME"
# Пароль пользователь OpenStack
user_password="USER_PASSWORD"
# Пароль для Редиса
redis_password="REDUS_PASSWORD"
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
master_host = "master.5579a1f3-12ab-4b6a-b926-49eb861feaa1.c.dbaas.selcloud.ru"
```

## Удаление стенда
```bash
terraform destroy --var-file="vars.tfvars"
```
