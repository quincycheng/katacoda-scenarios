#!/bin/bash

clear&&printf "Verifying environment..."&&while ! docker exec root_client_1 conjur list >/dev/null 2>&1;do printf ".";sleep 1s;done && echo -e "\nReady!"
