Applications and application developers should be **incapable of leaking secrets**.

To achieve that goal, you’ll play two roles in this tutorial:

1. A **Security Admin** who handles secrets, and has sole access to those secrets
2. An **Application Developer** with no access to secrets.

The situation looks like this:

![the situation](https://secretless.io/img/secretless_overview.jpg)

Specifically, we will:

**As the security admin:**

Create a PostgreSQL database
Create a DB user for the application
Add that user’s credentials to Kubernetes Secrets
Configure Secretless to connect to PostgreSQL using those credentials

**As the application developer:**

Configure the application to connect to PostgreSQL via Secretless
Deploy the application and the Secretless sidecar

Prerequisites
To run through this tutorial, all you need is this course!


To run through this tutorial **in your own environment**, you will need:

- A running Kubernetes cluster (you can use minikube to run a cluster locally)
- kubectl configured to point to the cluster
- Docker CLI
