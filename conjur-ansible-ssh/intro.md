Ansible is an agentless configuration management tool for provisioning, configuring, and deploying applications. Ansible is great for configuration management, but it’s not designed to manage secrets across multiple tools and cloud environments.

With this fully interactive hosted tutorial you will learn how to secure Ansible automation by keeping unsecured secrets out of Playbooks with Conjur open source secrets management.

All you need is a web browser and a few minutes to get started, no need to install anything!

In this tutorial, we will show you how to secure Ansible using Conjur to protect SSH secrets

We will need to manage two servers via SSH by Ansible.
Typically that'll involve:
1. Create SSH service accounts on the managed servers
2. Install Ansible
3. Prepare an inventory file to specify the connection details of the managed servers
4. Prepare a playbook to specifiy the tasks

# How it works?

![How it works](https://raw.githubusercontent.com/quincycheng/katacoda-scenarios/master/conjur-ansible-ssh/media/ansible.svg)

1. Install Cojur Role and Lookup Plug-in
2. Load an Conjur policy that grants the Ansible control machine privileges on secrets
3. Run a playbook containing references to secrets stored in Conjur
4. Authenticate the control machine to Conjur
5. Issue the secrets
6. Playbook runs containing secret

Let's get started!
