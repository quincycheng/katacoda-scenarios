
The application will be scoped to the quick-start-application-ns namespace.

To create the namespace run:

`kubectl create namespace quick-start-application-ns`{{execute}}

`namespace "quick-start-application-ns" created`

Next we’ll store the application-credentials in Kubernetes Secrets:

```
kubectl --namespace quick-start-application-ns \
  create secret generic quick-start-backend-credentials \
  --from-literal=address="${REMOTE_DB_URL}" \
  --from-literal=username="${APPLICATION_DB_USER}" \
  --from-literal=password="${APPLICATION_DB_INITIAL_PASSWORD}"
```{{execute}}

```
secret "quick-start-backend-credentials" created
```

Note: While Kubernetes Secrets are more secure than hard-coded ones, in a real deployment you should secure secrets in a fully-featured vault, like Conjur.
