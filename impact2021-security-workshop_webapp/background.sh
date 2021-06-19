#!/bin/bash
docker start root_database_1
sleep 3s
docker start root_client_1
docker start lamp
sleep 3s
docker start root_conjur_1
