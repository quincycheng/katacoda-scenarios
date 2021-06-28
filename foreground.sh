#!/bin/bash

# Wait for all containers to start and configure
while [ ! -f /usr/local/bin/wait.sh ]; do sleep 1; done; /usr/local/bin/wait.sh

rm -f /root/katacoda-finished
rm -f /root/katacoda-background-finished