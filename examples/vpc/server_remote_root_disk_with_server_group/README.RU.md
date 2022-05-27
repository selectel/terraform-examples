# Пример создания сервера с сетевым загрузочным диском

Используется два terraform провайдера:
- Selectel - для создания проекта, пользователя и роли.
- Openstack - для создания сервера с сетевым загрузочным диском.

## Пример запуска используя переменные окружения

```sh
terraform init

env \
  TF_VAR_sel_token=yyy_xxx \
  TF_VAR_user_password=secret \
  terraform apply
```