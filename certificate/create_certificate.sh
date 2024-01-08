#!/usr/bin/env bash

# Creating CA root
openssl genrsa -out selfsignCA.key 4096
openssl req -new -x509 -days 3650 -key selfsignCA.key -out selfsignCA.crt -subj "/CN=acme"
# Creating wildcard *.app.localhost
openssl genrsa -out app.key 2048
openssl req -new -nodes -key app.key -config openssl.cnf -out app.csr
openssl x509 -req -in app.csr -CA selfsignCA.crt -CAkey selfsignCA.key -CAcreateserial -out app.crt -days 1024 -sha256 -extfile openssl.cnf -extensions req_ext
# Moving to haproxy expected path
cat app.key app.crt selfsignCA.crt >> config/app.pem
# Cleaning
rm -rf app.crt app.csr app.key selfsignCA.key
