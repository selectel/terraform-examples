# HTTPS компоненты для создания балансировщиков

Модуль создания HTTPS компонентов балансировщика:
- listener
- pool
- monitor
- member

## Принимаемые переменные

  * `loadbalancer_id` - UUID балансировщика, для которого будут созданы компоненты.

  * `server_access_ips` - IP адреса серверов, на которые будет направляться трафик.

  * `lb_components` - Переменные компонентов балансировщика.

  * `vip_subnet_id` - UUID подсети, в которой находятся серверы.

  * `tls_container_ref` - UUID контейнера с сертификатом, хранящегося в менеджере секретов Селектел.
