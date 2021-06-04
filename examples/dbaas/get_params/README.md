# Получение списка переменных сервера

Просмотр значений с апи в регионе - список поддерживаемых баз данных и версия,список flavor, список расширений postgres.

# Запуск

## Подготовка
```bash
cp vars.tfvars.example vars.tfvars

# Далее нужно отредактировать vars.tfvars
vim vars.tfvars
```

```ini
# Токен, https://my.selectel.ru/profile/apikeys
sel_token="SEL_TOKEN"
# ID проекта Облачной Платформы
project_id="PROJECT_ID"
# Регион проекта Облачной Платформы
region="REGION"

```

## Получение серверных значений
```bash
# Инициализация терраформ-окружения
terraform init
# Применение манифеста
terraform apply --var-file="vars.tfvars"
```
