#!/bin/bash
docker start root_database_1
sleep 3s
docker start root_client_1
docker start lamp
sleep 3s
docker start root_conjur_1
CONJUR_AUTHN_LOGIN=$(docker exec root_client_1 printenv CONJUR_AUTHN_LOGIN)
CONJUR_APPLIANCE_URL=$(docker exec root_client_1 printenv CONJUR_APPLIANCE_URL)
CONJUR_AUTHN_API_KEY=$(docker exec root_client_1 awk 'NR==3 {print $NF}' /root/.netrc)
docker exec lamp bash -c 'export CONJUR_AUTHN_LOGIN=$CONJUR_AUTHN_LOGIN; export CONJUR_APPLIANCE_URL=$CONJUR_APPLIANCE_URL; export CONJUR_AUTHN_API_KEY=$CONJUR_AUTHN_API_KEY'