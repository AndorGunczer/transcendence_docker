#!/bin/bash

mkdir ssl

cd ssl

openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 365
openssl x509 -outform der -in cert.pem -out cert.crt

service postgresql start
sleep 10

su postgres

psql -c "CREATE USER project WITH PASSWORD '12345';"
psql -c "CREATE DATABASE transcendence;"
psql -c "ALTER DATABASE transcendence OWNER TO project;"

