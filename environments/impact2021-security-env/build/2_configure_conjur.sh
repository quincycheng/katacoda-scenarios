#!/bin/bash

# Get Policy files
git clone https://github.com/infamousjoeg/katacoda-scenarios.git
mkdir /opt/policies/
cp katacoda-scenarios/impact2021-security-workshop_webapp/assets/* /opt/policies

# Copy & load root.yml policy file
docker exec root_client_1 mkdir /policies/
docker cp /opt/policies/root.yml root_client_1:/policies/

# Output API key to /root/demouser.txt
docker exec root_client_1 conjur policy load root /policies/root.yml > demouser.txt

# Initialize devapp secret variables
docker exec root_client_1 conjur variable values add devapp/db_uname devapp1
docker exec root_client_1 conjur variable values add devapp/db_pass Cyberark1