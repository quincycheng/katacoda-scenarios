
## Securing Playbook

Let's configure the plugin using environment variables:

```
cd secure-playbook
export CONJUR_ACCOUNT="demo"
export CONJUR_APPLIANCE_URL="https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/"
export CONJUR_CERT_FILE="/root/conjur-demo.pem"
export CONJUR_AUTHN_LOGIN="host/ansible/ansible-01"
export CONJUR_AUTHN_API_KEY="$(tail -n +2 ansible.out | jq -r '.created_roles."demo:host:ansible/ansible-01".api_key')"
```{{execute}}

We can get the conjur client configuration from the client container:

```
docker cp conjur_client_1:/root/.conjurrc /root/
docker cp conjur_client_1:/root/conjur-demo.pem /root/
```{{execute}}

Let's review the sample inventory, which stores the 2 servers

```
cd ../secure-playbook
cat inventory
```{{execute}}

```
[demo_servers]
host1
host2
```


Let's review the sample playbook, which connects to 

`cat playbook.yml`{{execute}}

```
- hosts: demo_servers
  roles:
    - role: cyberark.conjur-lookup-plugin
  vars:
      ansible_connection: ssh      
      ansible_host: "{{ lookup('retrieve_conjur_variable', 'server/' + inventory_hostname+ '/host') }}"
      ansible_user: "{{ lookup('retrieve_conjur_variable', 'server/' + inventory_hostname+ '/user') }}"
      ansible_ssh_pass: "{{ lookup('retrieve_conjur_variable', 'server/' + inventory_hostname+ '/pass') }}"

  tasks:
    - name: Get user name
      shell: whoami
      register: theuser

    - name: Get host name
      shell: hostname
      register: thehost

    - debug: msg="I am {{ theuser.stdout }} at {{ thehost.stdout }}"

```

To disable host key checking:
`export ANSIBLE_HOST_KEY_CHECKING=False`{{execute}}

To execute the playbook:

`ansible-playbook -i inventory playbook.yml`{{execute}}

Sample result:

```
PLAY ***************************************************************************

TASK [setup] *******************************************************************
ok: [host2]
ok: [host1]

TASK [Get hostname] ************************************************************
changed: [host1]
changed: [host2]

TASK [debug] *******************************************************************
ok: [host1] => {
    "msg": "service01 "
}
ok: [host2] => {
    "msg": "service02 "
}

PLAY RECAP *********************************************************************
host1                      : ok=3    changed=1    unreachable=0    failed=0
host2                      : ok=3    changed=1    unreachable=0    failed=0

master $ vi playbook.yml
master $ ansible-playbook playbook.yml -i inventory

PLAY ***************************************************************************

TASK [setup] *******************************************************************
ok: [host2]
ok: [host1]

TASK [Get user name] ***********************************************************
changed: [host1]
changed: [host2]

TASK [Get host name] ***********************************************************
changed: [host2]
changed: [host1]

TASK [debug] *******************************************************************
ok: [host1] => {
    "msg": "I am  service01 at master"
}
ok: [host2] => {
    "msg": "I am  service02 at node01"
}

PLAY RECAP *********************************************************************
host1                      : ok=4    changed=2    unreachable=0    failed=0
host2                      : ok=4    changed=2    unreachable=0    failed=0
```
