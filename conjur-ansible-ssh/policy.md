The sample policies have been prepared for you. 

**Root policy**

Run `cat conjur.yml`{{execute}} to review the root policy
```
- !policy
  id: db

- !policy
  id: ansible
```
**db policy**

Run `cat db.yml`{{execute}} to review the root policy

```
- &variables
  - !variable host1/host
  - !variable host1/user
  - !variable host1/pass
  - !variable host2/host
  - !variable host2/user
  - !variable host2/pass

- !group secrets-users

- !permit
  resource: *variables
  privileges: [ read, execute ]
  roles: !group secrets-users

# Entitlements 
- !grant
  role: !group secrets-users
  member: !layer /ansible

```

**ansible policy**

Run `cat ansible.yml`{{execute}} to review the root policy

```
- !layer
- !host ansible-01
- !grant
  role: !layer
  member: !host ansible-01
```
### Load Conjur Policies

Now let's copy the policy files to Conjur CLI container and load them

**Load Root Policy**

```
docker cp conjur.yml root_client_1:/tmp/
docker-compose exec client conjur policy load --replace root /tmp/conjur.yml
```{{execute}}

**Load ansible Policy**
```
docker cp ansible.yml root_client_1:/tmp/
docker-compose exec client conjur policy load ansible /tmp/ansible.yml | tee ansible.out
```{{execute}}

**Load db Policy**
```
docker cp db.yml root_client_1:/tmp/
docker-compose exec client conjur policy load db /tmp/db.yml
```{{execute}}

### Add variable
Let's create secrets and add them to Conjur

Host 1 IP:
`docker-compose exec client conjur variable values add db/host1/host "[[HOST1_IP]]"`{{execute}}
Host 1 user name:
`docker-compose exec client conjur variable values add db/host1/user "service01"`{{execute}}
Host 1 password:
`docker-compose exec client conjur variable values add db/host1/pass "W/4m=cS6QSZSc*nd"`{{execute}}

Host 2 IP:
`docker-compose exec client conjur variable values add db/host2/host "[[HOST2_IP]]"`{{execute}}
Host 2 user name:
`docker-compose exec client conjur variable values add db/host2/user "service02"`{{execute}}
Host 2 password:
`docker-compose exec client conjur variable values add db/host2/pass "5;LF+J4Rfqds:DZ8"`{{execute}}


