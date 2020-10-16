
Let's deploy an app.   

## Database


`git clone https://github.com/quincycheng/katacoda-secretless-files.git`{{execute}}

`kubectl apply -f db/db.yml`{{execute}}


## App

We will make use of the pet store demo app from CyberArk (https://github.com/conjurdemos/pet-store-demo) as an example.

To deploy, execute:
`kubectl apply -f insecure/app.yml`{{execute}}

To get the endpoint of the service, execute:
`export URL=$(kubectl describe  service testapp-insecure --namespace=testapp |grep Endpoints | awk '{print $2}'  )`{{execute}}

To list all pet messages:

`curl $URL/pets`{{execute}}

To add a new message with a random name

`curl  -d "{\"name\": \"$(shuf -n 1 /usr/share/dict/american-english)\"}" -H "Content-Type: application/json" $URL/pet`{{execute}}

You can repeat the above actions to create & review multiple entries.

