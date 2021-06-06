#Ansible
apt-get update
apt-get upgrade -y

#Jenkins
docker pull jenkins/jenkins:lts-jdk11


cd /opt
git clone https://github.com/quincycheng/katacoda-env-cem-jenkins.git


# Script to start jenkins when session starts

cat << EOF > /opt/configure-environment.sh
#!/bin/bash
cd /opt/katacoda-env-cem-jenkins/
docker-compose up -d
EOF
chmod +x /opt/configure-environment.sh


