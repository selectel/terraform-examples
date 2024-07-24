#!/bin/bash

# create root key
openssl genrsa -out rootCA.key 4096
# create root certificate
openssl req -x509 -new -key rootCA.key -sha256 -days 1024 -out rootCA.crt -nodes -subj "/C=RU/ST=Leningradskaya Oblast/L=Saint-Petersburg/O=Selectel/OU=Org/CN=selectel.ru"
# create certificate key
openssl genrsa -out www.test-ssl-octavia.com.key 4096
# create certificate signing request
openssl req -new -sha256 -key www.test-ssl-octavia.com.key -subj "/C=RU/ST=Leningradskaya Oblast/L=Saint-Petersburg/O=Selectel/CN=www.test-ssl-octavia.com" -out www.test-ssl-octavia.com.csr
# verify csr
openssl req -in www.test-ssl-octavia.com.csr -noout -text
# generate certificate
openssl x509 -req -in www.test-ssl-octavia.com.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out www.test-ssl-octavia.com.crt -days 500 -sha256
# verify crt
openssl x509 -in www.test-ssl-octavia.com.crt -text -noout
# convert to pkcs12
openssl pkcs12 -export -inkey www.test-ssl-octavia.com.key -in www.test-ssl-octavia.com.crt -certfile rootCA.crt -passout pass: -out www.test-ssl-octavia.com.p12
# generate only jey and certificate
openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout ssl_certificate/_private_key.pem -out ssl_certificate/_cert.pem
