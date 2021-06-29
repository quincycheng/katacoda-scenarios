#!/bin/bash

docker start lamp

docker kill root_conjur_1
docker rm root_conjur_1

cd /root
docker-compose up -d

echo "done" >> /root/katacoda-finished
echo "done" >> /root/katacoda-background-finished
