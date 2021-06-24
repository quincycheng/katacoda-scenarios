#!/bin/bash

# Download the cybr-cli
docker run --name cybr-cli -d nfmsjoeg/cybr-cli:0.1.3-beta
docker cp cybr-cli:/app/cybr /usr/local/bin
docker rm -f cybr-cli