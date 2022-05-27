# Пример создания проекта, сервера с лицензией Windows.

Используется два terraform провайдера:
- Selectel - для создания проекта, пользователя и роли.
- Openstack - для создания инстансов, сетевой инфраструктуры, двух балансировщиков

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

## Выходные переменные

  * `server_id` - UUID созданного сервера.

  * `floating_ip` - Публичный IP адрес сервера.
