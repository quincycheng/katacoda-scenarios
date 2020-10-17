#!/bin/bash -ex
{ set +x; } 2>/dev/null
git clone https://github.com/quincycheng/katacoda-secretless-files.git > /dev/null 2>&1
/usr/bin/launch.sh
cd katacoda-secretless-files/ 
set -x; 
