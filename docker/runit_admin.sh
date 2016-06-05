#!/usr/bin/env bash
cd /srv/odania

echo "Register service in consul"
rake odania:register

# TODO this is only for develop! Will restart on every request
IP=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
echo "Starting shotgun ${IP}"
exec puma config.ru
