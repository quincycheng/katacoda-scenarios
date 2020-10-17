## Get the URL

To check whether the app is started & get the endpoint of the service, execute:
```
export URL=$(kubectl describe  service testapp-insecure --namespace=testapp |grep Endpoints | awk '{print $2}'  )
curl $URL
```{{execute}}

If a `curl` error is returned, that means the application is still being started.
Please wait for a couple of moments and try again

## Test the app

To list all pet messages, execute:
`curl $URL/pets`{{execute}}

If you exeucte the very first time, it should return `[]`, which means it's empty

To add a new message with a random name, execute:
`curl  -d "{\"name\": \"$(shuf -n 1 /usr/share/dict/american-english)\"}" -H "Content-Type: application/json" $URL/pet`{{execute}}

Now let's list all pet messages again by executing:
`curl $URL/pets`{{execute}}

You can repeat the above actions to create & review multiple entries.
