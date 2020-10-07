
PostgreSQL is stateful, so we’ll use a [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) to manage it.

## DEPLOY POSTGRESQL STATEFULSET

To deploy a PostgreSQL StatefulSet:

1. Create a dedicated namespace for the storage backend:

`kubectl create namespace quick-start-backend-ns`{{execute}}

`namespace "quick-start-backend-ns" created`

2. Create a self-signed certificate (see [PostgreSQL documentation for more info](https://www.postgresql.org/docs/9.6/ssl-tcp.html)):

```
openssl req -new -x509 -days 365 -nodes -text -out server.crt \
  -keyout server.key -subj "/CN=pg"
chmod og-rwx server.key
```{{execute}}

3. Store the certificate files as Kubernetes secrets in the `quick-start-backend-ns` namespace:

```
kubectl --namespace quick-start-backend-ns \
  create secret generic \
  quick-start-backend-certs \
  --from-file=server.crt \
  --from-file=server.key
```{{execute}}

`secret "quick-start-backend-certs" created`

**Note:** While Kubernetes Secrets are more secure than hard-coded ones, in a real deployment you should secure secrets in a fully-featured vault, like Conjur.

4. Create and save the PostgreSQL StatefulSet manifest in a file named pg.yml in your current working directory:

```
cat << EOF > pg.yml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: pg
  labels:
    app: quick-start-backend
spec:
  serviceName: quick-start-backend
  selector:
    matchLabels:
      app: quick-start-backend
  template:
    metadata:
      labels:
        app: quick-start-backend
    spec:
      securityContext:
        fsGroup: 999
      containers:
      - name: quick-start-backend
        image: postgres:9.6
        imagePullPolicy: IfNotPresent
        ports:
          - containerPort: 5432
        env:
          - name: POSTGRES_DB
            value: postgres
          - name: POSTGRES_USER
            value: security_admin_user
          - name: POSTGRES_PASSWORD
            value: security_admin_password
        volumeMounts:
        - name: backend-certs
          mountPath: "/etc/certs/"
          readOnly: true
        args: ["-c", "ssl=on", "-c", "ssl_cert_file=/etc/certs/server.crt", "-c", "ssl_key_file=/etc/certs/server.key"]
      volumes:
      - name: backend-certs
        secret:
          secretName: quick-start-backend-certs
          defaultMode: 384
EOF
```{{execute}}

Note: In the manifest above, the certificate files for your database server are mounted in a volume with defaultMode: 384 giving it permissions 0600 (Why? Because 600 in base 8 = 384 in base 10).
Note: The pod is deployed with 999 as the group associated with any mounted volumes, as indicated by fsGroup: 999. 999 is a the static postgres gid, defined in the postgres Docker image


5. Deploy the **PostgreSQL StatefulSet**:
`kubectl --namespace quick-start-backend-ns apply -f pg.yml`{{execute}}
`statefulset "pg" created`

This StatefulSet uses the DockerHub postgres:9.6 container.

On startup, the container creates a superuser from the environment variables POSTGRES_USER and POSTGRES_PASSWORD, which we set to the values security_admin_user and security_admin_password, respectively.

Going forward, we’ll call these values the admin-credentials, to distinguish them from the application-credentials our application will use.

In the scripts below, we’ll refer to the admin-credentials by the environment variables SECURITY_ADMIN_USER and SECURITY_ADMIN_PASSWORD.

6. To ensure the **PostgreSQL StatefulSet** pod has started and is healthy (this may take a minute or so), run:

`kubectl --namespace quick-start-backend-ns get pods`{{execute}}

```
NAME      READY     STATUS    RESTARTS   AGE
pg-0      1/1       Running   0          6s
```

## EXPOSE POSTGRESQL SERVICE

Our PostgreSQL StatefulSet is running, but we still need to expose it publicly as a Kubernetes service.

To expose the database, run:

```
cat << EOF > pg-service.yml
kind: Service
apiVersion: v1
metadata:
  name: quick-start-backend
spec:
  selector:
    app: quick-start-backend
  ports:
    - port: 5432
      targetPort: 5432
      nodePort: 30001
  type: NodePort

EOF
kubectl --namespace quick-start-backend-ns  apply -f pg-service.yml
```{{execute}}

`service "quick-start-backend" created`

Note:The service manifest above assumes you're using minikube, where NodePort is the correct service type; for a GKE cluser, you may prefer a different service type, such as a LoadBalancer.

The database is now available at [[HOST_IP]]:30001, which we’ll call the REMOTE_DB_URL.

The database has no data yet, but we can verify it works by logging in as the security admin and listing the users:

```
export SECURITY_ADMIN_USER=security_admin_user
export SECURITY_ADMIN_PASSWORD=security_admin_password
export REMOTE_DB_URL=[[HOST_IP]]:30001

docker run --rm -it -e PGPASSWORD=${SECURITY_ADMIN_PASSWORD} postgres:9.6 \
  psql -U ${SECURITY_ADMIN_USER} "postgres://${REMOTE_DB_URL}/postgres" -c "\du"
```{{execute}}

```
                                          List of roles
       Role name        |                         Attributes                    
     | Member of
------------------------+-------------------------------------------------------
-----+-----------
 security_admin_user    | Superuser, Create role, Create DB, Replication, Bypass
 RLS | {}

```

