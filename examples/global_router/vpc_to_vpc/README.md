# Пример создания двух серверов в разных регионах подключенных к GR

VM1_ru1 -> port_11 -> subnet_11 -> network_11 -> router_11 - fip11
                       |              |
                  gr_subnet_11  gr_network_11
                       |              |   
                       +------+-------+
                              |
                        gr_router
                              |
                       +------+-------+
                       |              |
                  gr_subnet_21  gr_network_21
                       |              |
VM1_ru2 -> port_21 -> subnet_21 -> network_21 -> router_21 - fip21

## Версии

Берем из документа: https://docs.selectel.ru/terraform/quickstart/

## Создание с использованием secrets.tfvars

```sh
  terraform init
  terraform apply -var-file secrets.tfvars
```

## Пример secrets.tfvars

```txt
username                  = "santa"
password                  = "clause"
domain_name               = "north"
project_name              = "home"
project_id                = "11111111111111111111111111111111"

region_name1              = "ru-1"
region_name2              = "ru-2"
target_zone1              = "ru-1a"
target_zone2              = "ru-2a"
```

## Дополнительно

При создании VM используется ssh ключ, который берется из локального файла:
 ~/.ssh/id_rsa.pub 

## Выходные переменные
Floating IPs для двух созданных серверов
