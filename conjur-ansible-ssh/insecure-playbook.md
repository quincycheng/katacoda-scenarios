

Here comes a typical ansible playbook & inventory

### inventory

`cat insecure-playbook\inventory`{{execute HOST1}}

### Playbook

`cat insecure-playbook\insecure-playbook.yml`{{execute HOST1}}

### inventory

`ansible-playbook -i insecure-playbook\inventory insecure-playbook\insecure-playbook.yml`{{execute HOST1}}
