# Пример создания двух серверов в разных регионах подключенных к GR

network_vpc    ->   subnet_vpc
       |               |      
gr_network_vpc ->  gr_subnet_vpc  <--- gr_static_route_vpc
       |                                |
       +-------+------------------------+
               |
           gr_router
               |
       +-------+
       |               
gr_network_dedic  ->  gr_subnet_dedic
        |         
network_dedic        

+ datasources:

global_router_service_v1
global_router_zone_v1
global_router_zone_group_v1
global_router_quota_v1


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

## Замечания для использования

При подключении облачной сети (cloud reosurces) необходимо, чтобы:
- `os_network_id` совпадал с uuid сети в Облаке и принадлежал проекту `project_id`
- `os_subnet_id` совпадал с uuid подсети в Облаке и являлся подсетью внутри указанной ранее сети `os_network_id`
- `subnet_cidr1` - должен совпадать с cidr подсети в Облаке `os_subnet_id`
- адреса `gw_ip1`, `gr_service_addresses1` - должны быть не заняты в подсети `os_subnet_id`


## Выходные переменные
Все resource и datasource
