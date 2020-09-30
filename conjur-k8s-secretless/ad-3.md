
We’re ready to deploy our application.

A detailed explanation of the manifest below is featured in the next step, [Appendix - Secretless Deployment Manifest Explained](https://secretless.io/tutorials/kubernetes/appendix.html) and isn’t needed to complete the tutorial.

To create the **quick-start-application.yml** manifest using the `APPLICATION_DB_NAME` above, run:

```
cat << EOF > quick-start-application.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: quick-start-application
  labels:
    app: quick-start-application
spec:
  replicas: 3
  selector:
    matchLabels:
      app: quick-start-application
  template:
    metadata:
      labels:
        app: quick-start-application
    spec:
      serviceAccountName: quick-start-application
      automountServiceAccountToken: true
      containers:
        - name: quick-start-application
          image: cyberark/demo-app:latest
          env:
            - name: DB_URL
              value: postgresql://localhost:5432/${APPLICATION_DB_NAME}?sslmode=disable
        - name: secretless-broker
          image: cyberark/secretless-broker:latest
          imagePullPolicy: IfNotPresent
          args: ["-f", "/etc/secretless/secretless.yml"]
          volumeMounts:
            - name: config
              mountPath: /etc/secretless
              readOnly: true
      volumes:
        - name: config
          configMap:
            name: quick-start-application-secretless-config
EOF
```{{execute}}
