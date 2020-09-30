
With our database ready and our credentials safely stored, we can now configure the Secretless Broker. We’ll tell it where to listen for connections and how to proxy them.

After that, the developer’s application can access the database **without ever knowing the application-credentials**.

A Secretless Broker configuration file defines the services that Secretless with authenticate to on behalf of your application.

To create **secretless.yml** in your current directory, run:

```
cat << EOF > secretless.yml
version: "2"
services:
  pets-pg:
    protocol: pg
    listenOn: tcp://localhost:5432
    credentials:
      address:
        from: kubernetes
        get: quick-start-backend-credentials#address
      username:
        from: kubernetes
        get: quick-start-backend-credentials#username
      password:
        from: kubernetes
        get: quick-start-backend-credentials#password
EOF
```{{execute}}

Here’s what this does:

- Defines a service called pets-pg that listens for PostgreSQL connections on localhost:5432
- Says that the database address, username and password are stored in Kubernetes Secrets
- Lists the ids of those credentials within Kubernetes Secrets

Note: This configuration is shared by all Secretless Broker sidecar containers. There is one Secretless sidecar in every application Pod replica.

Note: Since we don't specify an `sslmode` in the Secretless Broker config, it will use the default `require` value.

Next we create a Kubernetes `ConfigMap` from this secretless.yml:

```
kubectl --namespace quick-start-application-ns \
  create configmap \
  quick-start-application-secretless-config \
  --from-file=secretless.yml
```{{execute}}

```
configmap "quick-start-application-secretless-config" created

```
