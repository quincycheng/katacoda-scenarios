
The last task for the administrator is to prepare Conjur for Secretless Broker Sidecar
Documentation can be found [here](https://docs.conjur.org/Latest/en/Content/Get%20Started/scl_using-conjur-OSS.htm?tocpath=Integrations%7COpenShift%252C%20Kubernetes%7CDeploy%20Applications%7C_____2#AddyourapplicationtoConjurpolicy)

## Review the env setup

The table below summarizes what we have set up so far:

| Info                                       | Value                   | How we refer it                |
|--------------------------------------------|-------------------------|--------------------------------|
| Policy branch with target credentials      | app/testapp/secret      | ${APP_SECRETS_POLICY_BRANCH}   |
| Layer/group with access to secrets         | app/testapp/layer       | ${APP_SECRETS_READER_LAYER}    |
| Kubernetes authenticator name              | dev                     | ${AUTHENTICATOR_ID}            |
| Conjur instance Kubernetes namespace       | conjur-server           | ${OSS_CONJUR_NAMESPACE}        |
| Conjur instance Kubernetes service account | conjur-cluster          | ${CONJUR_SERVICE_ACCOUNT_NAME} |
| Conjur URL                                 | https://conjur.demo.com | ${CONJUR_APPLIANCE_URL}        |
| Conjur Account                             | default                 | ${CONJUR_ACCOUNT}              |
| Conjur Admin Login                         | admin                   | ${CONJUR_ADMIN_AUTHN_LOGIN}    |
| Conjur Admin API Key                       | MySecretP@ss1           | ${CONJUR_ADMIN_API_KEY}        |
| App Name                                   | testapp-secure          | ${APP_NAME}                    |
| App Namespace                              | testapp                 | ${APP_NAMESPACE}               |
| App Service Account Name                   | testapp-secure-sa       | ${APP_SERVICE_ACCOUNT_NAME}    |

## env.sh

A code snippet contains all the variables defined in the table above has been prepared for you.
To review it, execute `cat secretless/env.sh`{{execute HOST1}}

Let's make sure it is executable by `chmod +x secretless/env.sh`{{execute HOST1}}

## Add your application to Conjur policy
You can define your host using a variety of Kubernetes resources
Use the following bash code snippet to generate the policy, named app-policy.yml, to add your application to Kubernetes:

```
#!/usr/bin/env bash
. ./secretless/env.sh
cat << EOL > ./secretless/app-policy.yml
---
# Policy enabling the Kubernetes authenticator for your application
- !policy
  id: conjur/authn-k8s/${AUTHENTICATOR_ID}/apps
  body:
    - &hosts
      - !host
        id: service-account-based-app
        annotations:
          authn-k8s/namespace: ${APP_NAMESPACE}
          authn-k8s/service-account: ${APP_SERVICE_ACCOUNT_NAME}
          authn-k8s/authentication-container-name: ${APP_AUTHENTICATION_CONTAINER_NAME}
          kubernetes: "true"
    - !grant
      role: !layer
      members: *hosts
# Grant application's authn identity membership to the application secrets reader layer so authn identity inherits read privileges on application secrets
- !grant
  role: !layer ${APP_SECRETS_READER_LAYER}
  members:
  - !host /conjur/authn-k8s/${AUTHENTICATOR_ID}/apps/service-account-based-app
  
EOL
```{{execute HOST1}}


