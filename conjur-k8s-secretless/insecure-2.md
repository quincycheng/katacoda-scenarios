## Get the URL

To get the endpoint of the service, execute:
`export URL=$(kubectl describe  service testapp-insecure --namespace=testapp |grep Endpoints | awk '{print $2}'  )`{{execute}}

Let's verify the URL, it should be an IP & port combination
`echo $URL`{{execute}}

If it said `<none>` or empty, please wait for a couple of moments and try the first command to get the endpoint again

## Test the app

To list all pet messages, execute:
`curl $URL/pets`{{execute}}

If you exeucte the very first time, it should return `[]`, which means it's empty

To add a new message with a random name, execute:
`curl  -d "{\"name\": \"$(shuf -n 1 /usr/share/dict/american-english)\"}" -H "Content-Type: application/json" $URL/pet`{{execute}}

Now let's list all pet messages again by executing:
`curl $URL/pets`{{execute}}

You can repeat the above actions to create & review multiple entries.
