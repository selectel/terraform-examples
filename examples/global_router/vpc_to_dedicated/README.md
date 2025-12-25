# Пример создания сервера в облаке и выделенного сервера и соединения их через GR 

VM_vpc       -> port_11 -> subnet_11 -> network_11 -> router_11 - fip11
                       |              |
                  gr_subnet_11  gr_network_11  ------- gr_vpc_zone_ru_1
                       |              |   
                       +------+-------+
                              |
                        gr_router
                              |
                       +------+-------+
                       |              |
                  gr_subnet_21  gr_network_21 ------- gr_dedicated_zone_SPB_1
                       |              |
VM_dedicated -> port_21 -> subnet_21 -> network_21 -> router_21 - fip21

## Версии

Берем из документа: https://docs.selectel.ru/terraform/quickstart/

## Особенности создания топологии из шаблона

- Локальная сеть и подсеть для выделенного сервера должны быть созданы руками, ДО запуска terraform apply.
- IP адрес выделенного сервера задать до создания на данный момент нельзя
- После создания топологии необходимо зайти по ssh на выделенный сервер и добавить статический маршрут в сеть облачной VM.
Для дефолтных параметров шаблонов команда выглядит как:
```sh
  ip route add 10.1.11.0/24 via 10.2.11.1
```

## Пример создания

```sh
terraform init
env \
  TF_VAR_username=USER \
  TF_VAR_password=PASSWORD \
  TF_VAR_project_name=PROJECT_NAME \
  TF_VAR_project_id=PROJECT_ID \
  TF_VAR_domain_name=ACCOUNT_ID \
  terraform apply
```

## Выходные переменные
Floating IP - облачного сервера
