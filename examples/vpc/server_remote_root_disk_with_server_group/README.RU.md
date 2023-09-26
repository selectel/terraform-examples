# Пример создания сервера с сетевым загрузочным диском

Используется два terraform провайдера:
- Selectel - для создания проекта, пользователя и роли.
- Openstack - для создания сервера с сетевым загрузочным диском.

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
