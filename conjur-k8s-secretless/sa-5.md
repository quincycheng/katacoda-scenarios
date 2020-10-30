

In a Secretless Broker deployment, when a client needs access to a Target Service it doesn't try to make a direct connection. Instead, it sends the request through its Secretless Broker.

![secretless broker](https://docs.conjur.org/Latest/en/Content/Resources/Images/secretless_architecture.svg)

The following procedures are covered in this step:

1. Add the secrets to Conjur
2. Add the app to Conjur policy
3. Grant Conjur access to the pods in app namespace
4. Store Conjur SSL cert in a Config Map

## Add the secrets to Conjur

We'll create a layer, create & set 4 variables as secrets, and grant the layer to access all the variables.

`conjur load policy root /root/conjur/app-layer.yml`{{execute HOST1}}
`conjur load policy root /root/conjur/app-secrets.yml`{{execute HOST1}}
`conjur variable values add app/secret/testapp/db-password "5b3e5f75cb3cdc725fe40318"`{{execute HOST1}}
`conjur variable values add app/secret/testapp/db-user "test_app"`{{execute HOST1}}
`conjur variable values add app/secret/testapp/db-url "postgresql://testapp-db.testapp.svc.cluster.local:5432/postgres"`{{execute HOST1}}
`conjur variable values add app/secret/testapp/db-platform "postgres"`{{execute HOST1}}

## Add the app to Conjur policy

Next, we will add the app to Conjur policy

To review the policy, execute `cat conjur/app-policy.yml`{{execute HOST1}}

`conjur load policy root /root/conjur/app-policy.yml`{{execute HOST1}}
