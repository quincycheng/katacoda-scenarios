
We will now grant an application ID to the Ansible server.

Install the Conjur role using the following syntax:

```
ansible-galaxy install cyberark.conjur-host-identity
```{{execute}}

```
docker cp conjur_client_1:/root/conjur-demo.pem /root/
```{{execute}}


```
docker-compose exec client conjur hostfactory token create ansible|tee hftoken
```{{execute}}


```
export HFTOKEN="$(grep token hftoken | cut -d: -f2 | tr -d ' \r\n')" && echo $HFTOKEN
```{{execute}}

```
cat <<EOF > inventory
[servers]
host01
EOF
```{{execute}}
  
  
  
```
cat <<EOF > grant_conjur_id.yml
- hosts: servers
  roles:
    - role: cyberark.conjur-host-identity
      conjur_appliance_url: "https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com"
      conjur_account: "demo"
      conjur_host_factory_token: "{{lookup('env', 'HFTOKEN')}}"
      conjur_host_name: "{{inventory_hostname}}"
      conjur_ssl_certificate:  "{{lookup('file', '/root/conjur-demo.pem')}}"
      conjur_validate_certs: "false"
EOF
```{{execute}}
```
ansible-playbook -i inventory grant_conjur_id.yml
```{{execute}}
