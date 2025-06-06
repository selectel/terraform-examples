# Пример создания прерываемого сервера с сетевым загрузочным диском

Используется два terraform провайдера:
- Selectel - для создания проекта, пользователя и роли.
- Openstack - для создания сервера с сетевым загрузочным диском.

## Внимание!
Создание прерываемого сервера доступно только в ru-7a
При использовании этого примера в других регионах будут созданы обычные сервера.

## Для создания прерываемого сервера используйте переменную server_preemptible_tag
server_preemptible_tag = var.server_preemptible_tag

## Для смены прерываемого сервера на обычный используйте переменную server_no_preemptible_tag
server_preemptible_tag = var.server_no_preemptible_tag

## Для смены конфигурации сервера измените параметр flavor_id
flavor_id = "3032"

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
