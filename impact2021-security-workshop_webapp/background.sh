#!/bin/bash
docker start lamp

echo "done" >> /root/katacoda-finished

docker rm -f root_conjur_1
docker-compose up -d

echo "done" >> /root/katacoda-background-finished