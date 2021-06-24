#!/bin/bash
docker start root_database_1
sleep 3s
docker start root_client_1
docker start lamp
sleep 3s
docker start root_conjur_1

echo "done" >> /root/katacoda-finished

echo "done" >> /root/katacoda-background-finished