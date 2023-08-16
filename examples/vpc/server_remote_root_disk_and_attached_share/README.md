# Пример создания проекта, сервера подключенного к файловому хранилищу.

Используется два terraform провайдера:
- Selectel - для создания проекта, пользователя и роли.
- Openstack - для создания инстансов, сетевой инфраструктуры.

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

## или файла secrets.tfvars

```sh
  terraform apply -var-file secrets.tfvars
```

## Outputs

  * `server_ip` - external server IP address.

  * `share_id` - ID of the created share.

  * `share_export_location_path` - share mount path.
