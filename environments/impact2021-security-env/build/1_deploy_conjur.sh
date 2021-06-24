#!/bin/bash

docker pull mattrayner/lamp:latest-1804
docker pull nfmsjoeg/cybr-cli:0.1.3-beta

# Move to /root
cd /root || exit

# Install Conjur OSS quick-start
#curl -fsSL cybr.rocks/conjur-install | bash -s
curl -fsSL cybr.rocks/conjur-install -o conjur-install.sh 
chmod +x ./conjur-install.sh
./conjur-install.sh --no-update