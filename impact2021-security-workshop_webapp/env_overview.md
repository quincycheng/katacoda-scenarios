
The environment we'll be working in has Docker running with containers pre-deployed.

To view the containers running, execute the following command:
```
docker ps
```{{execute}}

The containers returned should be:
* mattrayner/lamp
* cyberark/conjur
* postgres

_NOTE: cyberark/conjur and postgres are combined into the same appliance container for Conjur Enterprise._

Let's break down each container's purpose for this scenario.

# cyberark/conjur
This container is the CyberArk Conjur service. It has been pre-configured for this scenario. As you have already experienced from the last executed command, it is online and available for serving requests.

# postgres
This container is the PostgreSQL database backend that stores the secrets used by the CyberArk Conjur service encrypted.

# mattrayner/lamp
This container is a full LAMP stack. LAMP stands for Linux, Apache, MySQL and PHP. This stack has been pre-configured and is waiting on us to provide a web application in the local `/opt/app` directory.

Let's create a quick index page and add a simple message to it:

<pre class="file" data-filename="index.php" data-target="replace">Hello, World!</pre>

To view the current website, click the `Web App` tab next to `Terminal`.