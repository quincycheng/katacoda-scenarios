#!/bin/bash
set +H
clear && printf "Verifying environment..." && sleep 1s && timeout 30s bash -c 'while ! [ -f /root/insecure-playbook/insecure-playbook.yml ];do printf ".";sleep 1s;done' && echo -e "\nReady!"
