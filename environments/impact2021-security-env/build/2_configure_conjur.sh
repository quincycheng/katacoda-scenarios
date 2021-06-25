#!/bin/bash

# Deploy & Configure Conjur CLI
docker run --name cli -d --restart always --network conjur \
    -v /root/policy:/policy \
    --entrypoint sleep
    cyberark/conjur-cli:5-latest infinity
docker exec -i cli conjur init --account impact2021 --url https://conjur <<< yes
docker exec conjur authn login -u admin -p CYberark11@@

# Get Policy files
git clone https://github.com/infamousjoeg/katacoda-scenarios.git
mkdir /opt/policies/
cp katacoda-scenarios/impact2021-security-workshop_webapp/assets/* /opt/policies

# Copy & load root.yml policy file
docker exec cli mkdir /policies/
docker cp /opt/policies/root.yml cli:/policies/

# Output API key to /root/demouser.txt
docker exec cli conjur policy load root /policies/root.yml > demouser.txt

# Initialize devapp secret variables
docker exec cli conjur variable values add devapp/db_uname devapp1
docker exec cli conjur variable values add devapp/db_pass Cyberark1