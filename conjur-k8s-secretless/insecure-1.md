
Let's deploy an app.   

## Database

Let's setup a database for the application

`kubectl apply -f db/db.yml`{{execute HOST1}}}


## App

We will make use of the pet store demo app from CyberArk (https://github.com/conjurdemos/pet-store-demo) as an example.

To deploy, execute:
`kubectl apply -f insecure/app.yml`{{execute HOST1}}}

Now the application has been installed.
We will try it out in the next step
