
The environment we'll be working in has Docker running with containers pre-deployed.

To view the containers running, execute the following command:
```
docker ps
```{{execute}}

The containers returned should be:
* cybr-cli
* lamp
* conjur

Let's break down each container's purpose for this scenario.

# cybr-cli
The cybr-cli is an open source project located at [https://github.com/infamousjoeg/cybr-cli](https://github.com/infamousjoeg/cybr-cli) and written in Go. It is available for Windows, Linux and MacOS + MacOS ARM.  Even though this CLI works with most CyberArk APIs, we'll be using it today to interact with the Conjur API.

Next, let's see what resources in Conjur our user has access to. To do this, execute the following command:
```
docker exec cybr-cli cybr conjur list
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

The last two secrets are what we'll be working with today to connect our web application to MySQL.

To view the value of `db_uname`, execute the following command: `docker exec cybr-cli cybr conjur get-secret -i devapp/db_uname`{{execute}}

To view the value of `db_pass`, execute the following command: `docker exec cybr-cli cybr conjur get-secret -i devapp/db_pass`{{execute}}

# conjur
This container is the CyberArk Conjur appliance. It has been pre-configured for this scenario. As you have already experienced from the last executed command, it is online and available for serving requests. 

# lamp
This container is a full LAMP stack. LAMP stands for Linux, Apache, MySQL and PHP. This stack has been pre-configured and is waiting on us to provide a web application in the local `/opt/app` directory.

Let's create a quick index page and add a simple message to it:

<pre class="file" data-filename="index.php" data-target="replace">Hello, World!</pre>

To view the current website, click the `Web App` tab next to `Terminal`.