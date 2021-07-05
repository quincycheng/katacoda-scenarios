set +H
clear && printf "Verifying environment..." && docker kill $(docker ps -aq) && docker rm $(docker ps -aq)&& echo -e "\nReady!"
