#Ansible
apt-get update
apt-add-repository --yes --update ppa:ansible/ansible
apt-get install ansible sshpass -y
apt install -y wamerican
apt-get upgrade -y

export ANSIBLE_HOST_KEY_CHECKING=False

#Conjur
curl -o docker-compose.yml https://quincycheng.github.io/docker-compose.quickstart.yml
docker-compose pull
docker-compose run --no-deps --rm conjur data-key generate > data_key

docker pull postgres:9.6
