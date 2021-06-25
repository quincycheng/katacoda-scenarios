#!/bin/bash

#debug
echo "*** START of impact2021-security-env ***"


docker pull mattrayner/lamp:latest-1804
docker pull nfmsjoeg/cybr-cli:0.1.3-beta

# Move to /root
cd /root || exit

# Install Conjur OSS quick-start
curl -o docker-compose.yml https://quincycheng.github.io/docker-compose.quickstart.yml
docker-compose pull
docker-compose run --no-deps --rm conjur data-key generate > data_key
export CONJUR_DATA_KEY="$(< data_key)"
docker-compose up -d

sleep 15
docker-compose exec conjur conjurctl account create quick-start | tee admin.out
docker-compose exec client bash -c "echo yes | conjur init -u conjur -a quick-start"

sleep 10
api_key="$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')"
docker-compose exec client conjur authn login -u admin -p "$api_key"

echo "$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' root_conjur_1) conjur" >> /etc/hosts
