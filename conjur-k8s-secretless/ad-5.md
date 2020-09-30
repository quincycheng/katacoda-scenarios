The application is running, but not yet publicly available.

To expose it publicly as a Kubernetes Service, run:

```
cat << EOF > quick-start-application-service.yml
kind: Service
apiVersion: v1
metadata:
  name: quick-start-application
spec:
  selector:
    app: quick-start-application
  ports:
  - port: 8080
    targetPort: 8080
    nodePort: 30002
  type: NodePort
EOF
kubectl --namespace quick-start-application-ns \
 apply -f quick-start-application-service.yml
```{{execute}}

```
service "quick-start-application" created
```
Congratulations!

The application is now available at `$(minikube ip):30002`. We’ll call this the `APPLICATION_URL` going forward.
