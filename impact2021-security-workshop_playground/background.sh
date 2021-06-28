#!/bin/bash
docker start root_database_1
docker start lamp
docker start cybr-cli

timeout 90s bash -c "until docker exec root_database_1 pg_isready ; do sleep 3 ; done"


docker start root_conjur_1

echo "done" >> /root/katacoda-finished
echo "done" >> /root/katacoda-background-finished