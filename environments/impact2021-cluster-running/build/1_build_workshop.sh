#!/bin/bash

#Ansible
apt-get update
apt-add-repository --yes --update ppa:ansible/ansible
apt-get update
apt-get install ansible sshpass -y
apt-get install -y wamerican

export ANSIBLE_HOST_KEY_CHECKING=False

# Update apt repos and install deps
apt-get install -y mysql-client-core-5.7 jq


# Deploy LAMP & create MySQL database and user
mkdir /opt/mysql
mkdir /opt/app
cd /opt
docker pull mattrayner/lamp:latest-1804
docker run --name lamp -d -p "80:80" -p "3306:3306" -v /opt/app:/app -v /opt/mysql:/var/lib/mysql mattrayner/lamp:latest-1804
# sleep for 1 min to make sure MySQL is up & running
sleep 1m 
# Add "use conjur_demo"
docker exec lamp mysql -h localhost --port=3306 -uroot \
    -e "CREATE DATABASE conjur_demo;  CREATE USER 'devapp1' IDENTIFIED BY 'Cyberark1'; GRANT ALL PRIVILEGES ON conjur_demo.* TO 'devapp1'; FLUSH PRIVILEGES; USE conjur_demo; CREATE TABLE IF NOT EXISTS conjur_demo.demo (message VARCHAR(255) NOT NULL) ENGINE=MyISAM DEFAULT CHARSET=utf8; INSERT INTO demo (message) VALUES ('If you are seeing this message, we have successfully connected PHP to our backend MySQL database!');"


# Get Policy files
git clone https://github.com/infamousjoeg/katacoda-scenarios.git
mkdir /opt/policies/
cp katacoda-scenarios/impact2021-security-workshop_webapp/assets/* /opt/policies


# Move to /root
cd /root

# Install Conjur OSS quick-start
#curl -fsSL cybr.rocks/conjur-install | bash -s
curl -fsSL cybr.rocks/conjur-install -o conjur-install.sh 
chmod +x ./conjur-install.sh
./conjur-install.sh --no-update

# Copy & load root.yml policy file
docker exec root_client_1 mkdir /policies/
docker cp /opt/policies/root.yml root_client_1:/policies/

# Output API key to /root/demouser.txt
docker exec root_client_1 conjur policy load root /policies/root.yml > demouser.txt

# Initialize devapp secret variables
docker exec root_client_1 conjur variable values add devapp/db_uname devapp1
docker exec root_client_1 conjur variable values add devapp/db_pass Cyberark1

# script will be run when the session starts 
cat << EOF > /opt/configure-environment.sh
#!/bin/bash
docker start root_database_1
docker start lamp
docker start root_conjur_1
docker start root_client_1
EOF
chmod +x /opt/configure-environment.sh