
To deploy the application, run:

```
kubectl --namespace quick-start-application-ns apply -f quick-start-application.yml
```{{execute}}

```
deployment "quick-start-application" created
```

Before moving on, verify that the pods are healthy:

```
kubectl --namespace quick-start-application-ns get pods
```{{execute}}

```
NAME                                       READY     STATUS        RESTARTS   AGE
quick-start-application-6bd8dbd57f-bshmf   2/2       Running       0          22s
quick-start-application-6bd8dbd57f-dr962   2/2       Running       0          26s
quick-start-application-6bd8dbd57f-fgfnh   2/2       Running       0          30s
```
