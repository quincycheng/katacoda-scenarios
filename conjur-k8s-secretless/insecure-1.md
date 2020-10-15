
Let's deploy an app.   

## Database

https://github.com/quincycheng/katacoda-secretless-files.git

`kubectl apply -f db/db.yml`{{execute}}


## App

We will make use of the pet store demo app from CyberArk (https://github.com/conjurdemos/pet-store-demo) as an example.


`kubectl apply -f insecure/app.yml`{{execute}}


`export insecure_app_url=$(kubectl describe service test-app | grep 'LoadBalancer Ingress' | awk '{ print $3 }'):8080`{{execute}}
