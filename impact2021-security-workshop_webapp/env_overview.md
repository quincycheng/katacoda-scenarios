
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

_NOTE: cyberark/conjur and postgres are combined into the same appliance container for Conjur Enterprise._

Let's break down each container's purpose for this scenario.

# conjurinc/cli5
This container is the CyberArk Conjur CLI. It has been pre-configured and should be authenticated to the cyberark/conjur container.

To test this, execute the following command:
```
docker exec root_client_1 conjur list
```{{execute}}

If everything is authenticated properly, you should have received the following response:

```
[
  "quick-start:policy:root",
  "quick-start:user:demouser",
  "quick-start:policy:devapp",
  "quick-start:group:devapp/secret-users",
  "quick-start:variable:devapp/db_uname",
  "quick-start:variable:devapp/db_pass"
]
```

# cyberark/conjur
This container is the CyberArk Conjur service. It has been pre-configured for this scenario. As you have already experienced from the last executed command, it is online and available for serving requests.

# postgres
This container is the PostgreSQL database backend that stores the secrets used by the CyberArk Conjur service encrypted.

# mattrayner/lamp
This container is a full LAMP stack. LAMP stands for Linux, Apache, MySQL and PHP. This stack has been pre-configured and is waiting on us to provide a web application in the local `/opt/app` directory.