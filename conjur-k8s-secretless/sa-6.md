
To grant our application access to the credentials in Kubernetes Secrets, we’ll need a ServiceAccount:

```
kubectl --namespace quick-start-application-ns \
  create serviceaccount \
  quick-start-application
```{{execute}}

```
serviceaccount "quick-start-application" created
```

Next we grant this ServiceAccount “get” access to the quick-start-backend-credentials. This is a 2 step process:

1. Create a Role with permissions to get the quick-start-backend-credentials secret
2. Create a RoleBinding so our ServiceAccount has this Role

Run this command to perform both steps:

```
cat << EOF > quick-start-application-entitlements.yml
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: quick-start-backend-credentials-reader
rules:
- apiGroups: [""]
  resources: ["secrets"]
  resourceNames: ["quick-start-backend-credentials"]
  verbs: ["get"]

---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: read-quick-start-backend-credentials
subjects:
- kind: ServiceAccount
  name: quick-start-application
roleRef:
  kind: Role
  name: quick-start-backend-credentials-reader
  apiGroup: rbac.authorization.k8s.io
EOF

kubectl --namespace quick-start-application-ns \
  apply -f quick-start-application-entitlements.yml
```{{execute}}

```
role "quick-start-backend-credentials-reader" created
rolebinding "read-quick-start-backend-credentials" created
```
