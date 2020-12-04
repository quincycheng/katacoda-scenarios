

Let's convert the conjur identity to make it compatible with Ansible:

```
sed -i "s=login host/=login host%2F=" /etc/conjur.identity
```{{execute}}

Let's review the sample inventory, which stores the 2 servers

```
cd ../secure-playbook
cat inventory
```{{execute}}

Let's review the sample playbook, which connects to 
`cat playbook.yml`{{execute}}

To execute the playbook:
`ansible-playbook -i inventory playbook.yml`{{execute}}

Sample result:

```

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
