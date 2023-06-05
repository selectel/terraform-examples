# Пример создания проекта, сервера подключенного к файловому хранилищу.

Используется два terraform провайдера:
- Selectel - для создания проекта, пользователя и роли.
- Openstack - для создания инстансов, сетевой инфраструктуры.

## Содержание secrets.tfvars

  * `sel_token` - Ключ API из настроек профиля в панели управления.

  * `user_password` - Пароль пользователя, который будет создан.

## Пример запуска используя переменные окружения

```sh
terraform init

env \
  TF_VAR_sel_token=xxx_yyy \
  TF_VAR_user_password=secret \
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
