

### To install Ansible:

```
apt-get update
apt-add-repository --yes --update ppa:ansible/ansible
apt-get install ansible sshpass -y
export ANSIBLE_HOST_KEY_CHECKING=False
```{{execute HOST1}}

### To verify the installation

`ansible -version`{{execute HOST1}}
