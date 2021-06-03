#!/bin/bash

# Update apt repos and install deps
apt-get update
apt-get install -y mysql-client-core-5.7 jq

docker pull mattrayner/lamp:latest-1804

# Deploy LAMP & create MySQL database and user
docker run --name lamp -d -p "80:80" -v ${PWD}/app:/app mattrayner/lamp:latest-1804
docker exec lamp mysql -h localhost -uroot \
    -e "CREATE DATABASE conjur_demo; CREATE USER 'devapp1' IDENTIFIED BY 'Cyberark1'; GRANT ALL PRIVILEGES ON conjur_demo.* TO 'devapp1'; FLUSH PRIVILEGES; CREATE TABLE IF NOT EXISTS conjur_demo.demo (message VARCHAR(255) NOT NULL) ENGINE=MyISAM DEFAULT CHARSET=utf8; INSERT INTO demo (message) VALUES ('If you are seeing this message, we have successfully connected PHP to our backend MySQL database!');"

#move to /root
cd /root

# Install Conjur OSS quick-start
curl -fsSL cybr.rocks/conjur-install | bash -s

echo "done" >> /root/katacoda-finished


# Copy & load root.yml policy file
docker cp /policies/* root_client_1:/policies/
# Output API key to /root/demouser.txt
docker exec root_client_1 conjur policy load root /policies/root.yml > demouser.txt

# Add alias for Conjur CLI to .bashrc
echo "alias conjur='docker exec root_client_1 conjur'" >> /root/.bashrc

# Initialize devapp secret variables
docker exec root_client_1 conjur variable values add devapp/db_uname devapp1
docker exec root_client_1 conjur variable values add devapp/db_pass Cyberark1

echo "done" >> /root/katacoda-background-finished
