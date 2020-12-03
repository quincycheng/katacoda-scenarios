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

Let's get started!
