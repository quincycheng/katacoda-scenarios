

In a Secretless Broker deployment, when a client needs access to a Target Service it doesn't try to make a direct connection. Instead, it sends the request through its Secretless Broker.

![secretless broker](https://docs.conjur.org/Latest/en/Content/Resources/Images/secretless_architecture.svg)

The following procedures are covered in this step:

1. Add the secrets to Conjur
2. Add the app to Conjur policy
3. Grant Conjur access to the pods in app namespace
4. Store Conjur SSL cert in a Config Map

## Add the secrets to Conjur




## Add the app to Conjur policy

