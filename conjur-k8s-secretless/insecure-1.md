
Let's deploy an app.   

## Database


`git clone https://github.com/quincycheng/katacoda-secretless-files.git`{{execute}}

`kubectl apply -f db/db.yml`{{execute}}


## App

We will make use of the pet store demo app from CyberArk (https://github.com/conjurdemos/pet-store-demo) as an example.


`kubectl apply -f insecure/app.yml`{{execute}}

`kubectl get services --namespace=testapp`{{execute}}
