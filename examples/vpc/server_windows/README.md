# Пример создания проекта, сервера с лицензией Windows.

Используется два terraform провайдера:
- Selectel - для создания проекта, пользователя и роли.
- Openstack - для создания инстансов, сетевой инфраструктуры, двух балансировщиков

## Содержание secrets.tfvars

  * `username` - Имя сервисного пользователя.
  * `password` - Пароль сервисного пользователя.
  * `domain_name` - ID аккаунта.
  * `user_password` - Пароль пользователя, который будет создан.

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


## Выходные переменные

  * `server_id` - UUID созданного сервера.

  * `floating_ip` - Публичный IP адрес сервера.
