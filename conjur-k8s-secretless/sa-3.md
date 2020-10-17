

In this section, we'll configure the following items for setting up the Conjur client:

1. Alias for CLI
2. Reset Admin password
3. Logging in


## Alias for Conjur CLI

Conjur CLI client can be either installed as [Ruby gem](https://docs.conjur.org/Latest/en/Content/Tools/CLI_Install_CLI.htm?tocpath=Setup%7C_____2#ruby-gem) or [Docker Container)[https://docs.conjur.org/Latest/en/Content/Tools/CLI_Install_CLI.htm?tocpath=Setup%7C_____2#docker-container]
In order to have the best of both worlds, we will create an alias to execute the CLI as container

```
alias conjur='docker run --rm -it --add-host conjur.demo.com:$SERVICE_IP -v $(pwd)/mydata/:/root cyberark/conjur-cli:5 '
```

In your own environment, you may wish to add it in shell script file, e.g. `~/.bashrc` or `~/.zshrc`

## Initalize Conjur CLI


`conjur init --url conjur.demo.com --account default`{{execute}}


## Login 

Now, we will need to logon to Conjur CLI.
Remember the admin API key?  Don't worry, we can get it by executing `grep admin admin.out`{{execute}}



## Reset Admin Password

This step is optional.   However, like any other systems, it is highly recommended to change the password regularly.
Visit [CyberArk.com](https://cyberark.com) to learn how CyberArk can help you to develop and deploy effective identity security strategies.

Let's update our admin password to `Cyberark1`
```
conjur user update_password -p Cyberark1
```{{execute}}

Next, Log off & on again with the new password `Cyberark1`
```
conjur authn logout

```{{execute}}





