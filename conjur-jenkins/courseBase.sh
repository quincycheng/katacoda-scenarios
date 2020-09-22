#!/bin/bash

git clone https://github.com/quincycheng/katacoda-env-conjur-jenkins.git

cd katacoda-env-conjur-jenkins

docker run -d -p 8080:8080 -p 50000:50000 --name jenkins -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts
docker run -d -p 8111:80 --name http-authn-server http-authn-server:1.0

curl -o docker-compose.yml https://quincycheng.github.io/docker-compose.quickstart.yml
docker-compose pull
docker-compose run --no-deps --rm conjur data-key generate > data_key
export CONJUR_DATA_KEY="$(< data_key)"
docker-compose up -d 
#sleep 15
#docker-compose exec conjur conjurctl account create demo | tee admin.out
#docker-compose exec client bash -c "echo yes | conjur init -u $1 -a demo"

# sleep 10
# api_key="$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')"
# docker-compose exec client conjur authn login -u admin -p "$api_key"

echo "$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' conjur_conjur_1) conjur" >> /etc/hosts
