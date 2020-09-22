
We will now grant an application ID to the Ansible server.

Install the Conjur role using the following syntax:

```
ansible-galaxy install cyberark.conjur-host-identity
```{{execute}}


```
docker-compose exec client conjur hostfactory token create ansible|tee hftoken
```{{execute}}

```
cat <<EOF > inventory
[servers]
localhost
EOF
```{{execute}}
  
  
  
```
cat <<EOF > insecure-playbook/inventory
- hosts: servers
  roles:
    - role: cyberark.conjur-host-identity
      conjur_appliance_url: 'https://conjur.myorg.com/api',
      conjur_account: 'myorg',
      conjur_host_factory_token: "{{lookup('env', 'HFTOKEN')}}",
      conjur_host_name: "{{inventory_hostname}}"
      
```{{execute}}
```
ansible-playbook -i inventory grant_conjur_id.yml
```{{execute}}
