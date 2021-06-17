
The environment we'll be working in has Docker running with containers pre-deployed.

To view the containers running, execute the following command:
```
docker ps
```{{execute}}

The containers returned should be:
* conjurinc/cli5
* cyberark/conjur
* postgres
* mattrayner/lamp

Let's break down each container's purpose for this scenario.

# conjurinc/cli5
This container is the CyberArk Conjur CLI. It has been pre-configured and should be authenticated to the cyberark/conjur container.

To test this, execute the following command:
```
docker exec root_client_1 conjur list
```{{execute}}

