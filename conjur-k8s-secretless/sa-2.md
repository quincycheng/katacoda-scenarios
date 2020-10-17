
## Setup Conjur 

```
kubectl create namespace conjur-server
```{{execute}}

Let's install Conjur using Helm.

First, we need to add `cyberark` repo to Helm
```
helm repo add cyberark https://cyberark.github.io/helm-charts
```{{execute}}

The response should look like this:
```
"cyberark" has been added to your repositories
```
Try the above command again if it shows something else

Then we'll update the repo
```
helm repo update
```{{execute}}

```
...Successfully got an update from the "cyberark" chart repository
Update Complete. ⎈ Happy Helming!⎈
```
Try the above command again if it shows something else


Next, we need to add a role binding

```
kubectl apply -f conjur/role-binding.yaml
```{{execute}}
```
rolebinding.rbac.authorization.k8s.io/conjur-server-authn-role-binding created
```


Lastly, we can install Conjur by the following command.
Please note that it'll take a short while.

```
helm install conjur-cluster cyberark/conjur-oss \
     --set ssl.hostname=conjur.demo.com,dataKey="$(docker run --rm cyberark/conjur data-key generate)",authenticators="authn-k8s/dev\,
 authn" \
     --set postgres.persistentVolume.create=false \
     --set resources.limits.memory=1Gi \
     --set resources.requests.memory=1Gi \
     --set servie.external.enabled=false \
     --namespace conjur-server
```{{execute}}

The system should return a long message showing how to proceed.

We'll need to get the pod name of Conjur.
```
 export POD_NAME=$(kubectl get pods --namespace conjur-server \
   -l "app=conjur-oss,release=conjur-cluster" \
   -o jsonpath="{.items[0].metadata.name}")
```{{execute}}

...in order to create an account, let's call it `default`

```
kubectl exec --namespace conjur-server \
    $POD_NAME \
  --container=conjur-oss \
  -- conjurctl account create "default" | tee admin.out
```{{execute}}
 
And Conjur is now up & running.
Please note that we've stored the public key and admin API key in `admin.out` file.
In production, please keep them safe & secure.
                  
