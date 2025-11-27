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

# cloud resources
os_network_id             = "11111111-2222-3333-4444-555555555555"
os_subnet_id              = "d15d0f24-a8fd-49f0-8249-26a7c01020e0"
stat_route_cidr           = "0.0.0.0/0"
next_hop_ip               = "10.1.11.1"
subnet_cidr1              = "10.1.11.0/24"
gw_ip1                    = "10.1.11.2"
region_cloud              = "ru-1"
gr_service_addresses1     = ["10.1.11.253", "10.1.11.254"]

# dedicated resources
subnet_cidr2              = "10.2.11.0/24"
gw_ip2                    = "10.2.11.2"
dedicated_vlan            = 3184
region_dedicated          = "SPB-4"
gr_service_addresses2     = ["10.2.11.253", "10.2.11.254"]
```


## Замечания для использования

При подключении облачной сети (cloud reosurces) необходимо, чтобы:
- `os_network_id` совпадал с uuid сети в Облаке и принадлежал проекту `project_id`
- `os_subnet_id` совпадал с uuid подсети в Облаке и являлся подсетью внутри указанной ранее сети `os_network_id`
- `subnet_cidr1` - должен совпадать с cidr подсети в Облаке `os_subnet_id`
- адреса `gw_ip1`, `gr_service_addresses1` - должны быть не заняты в подсети `os_subnet_id`


## Выходные переменные
Все resource и datasource
