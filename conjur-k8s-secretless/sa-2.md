
## Setup Conjur 

```
kubectl create namespace conjur-server
```{{execute}}

Let's install Conjur using Helm.

First, we need to add `cyberark` repo to Helm
```
helm repo add cyberark https://cyberark.github.io/helm-charts
helm repo update
```{{execute}}

Next, we need to add a role binding

```
kubectl apply -f conjur/role-binding.yaml
```{{execute}}

Lastly, we can install Conjur

```
helm install conjur-cluster cyberark/conjur-oss \
    --set ssl.hostname=conjur.demo.com,dataKey="$(docker run --rm cyberark/conjur data-key generate)",authenticators="authn-k8s/dev\,
authn" \
    --set resources.limits.memory=1Gi \
    --set resources.requests.memory=1Gi \
    --namespace conjur-server 
```{{execute}}




```
      export POD_NAME=$(kubectl get pods --namespace conjur-server \
                                         -l "app=conjur-oss,release=conjur-cluster" \
                                         -o jsonpath="{.items[0].metadata.name}")
```{{execute}}

```
kubectl exec --namespace conjur-server \
                   $POD_NAME \
                   --container=conjur-oss \
                   -- conjurctl account create "default"
                   
                   
```{{execute}}
                   
                   
                   
                   
                   
                   
