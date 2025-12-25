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

## Дополнительно

При создании VM используется ssh ключ, который берется из локального файла:
 ~/.ssh/id_rsa.pub 

## Выходные переменные
Floating IPs для двух созданных серверов
