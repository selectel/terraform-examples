# Пример создания нескольких серверов с сетевым загрузочным диском, сетевой инфраструктурой и файерволом.

Используется два terraform провайдера:
- Selectel - для создания проекта, пользователя и роли.
- Openstack - для создания инфраструктуры.

## Внимание!
Применение этого примера в Облаке Selectel возможно только после выхода FWaaS из альфа тестирования.

## Пример запуска используя переменные окружения

```sh
terraform init

env \
  TF_VAR_username=USER \
  TF_VAR_password=PASSWORD \
  TF_VAR_domain_name=ACCOUNT_ID \
  TF_VAR_user_password=xxx \
  terraform apply
```

## Пример запуска используя файл с чувствительными данными

```sh
terraform init

terraform apply -var-file=secrets.tfvars
```
