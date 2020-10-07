

In this section, we assume the following:

- You already have a PostgreSQL database exposed as a Kubernetes service.
- It’s publicly available via the URL in `REMOTE_DB_URL`
- You have admin-level database credentials
- The `SECURITY_ADMIN_USER` and `SECURITY_ADMIN_PASSWORD` environment variables hold those credentials

Note: If you're using your own database server and it's not SSL-enabled, please see the [service authenticator documentation](https://docs.secretless.io/Latest/en/Content/References/handlers/postgres.htm) for how to disable SSL in your Secretless configuration.

If you followed along in the last section, you can run:

```
export SECURITY_ADMIN_USER=security_admin_user
export SECURITY_ADMIN_PASSWORD=security_admin_password
export REMOTE_DB_URL="[[HOST_IP]]:30001"
```{{execute}}

Next, we’ll create the application database and user, and securely store the user’s credentials:

1. Create the application database
2. Create the pets table in that database
3. Create an application user with limited privileges: SELECT and INSERT on the pets table
4. Store these database application-credentials in Kubernetes secrets.

So we can refer to them later, export the database name and application-credentials as environment variables:

```
export APPLICATION_DB_NAME=quick_start_db

export APPLICATION_DB_USER=app_user
export APPLICATION_DB_INITIAL_PASSWORD=app_user_password
```{{execute}}

Finally, to perform the 4 steps listed above, run:

```
docker run --rm -i -e PGPASSWORD=${SECURITY_ADMIN_PASSWORD} postgres:9.6 \
    psql -U ${SECURITY_ADMIN_USER} "postgres://${REMOTE_DB_URL}/postgres" \
    << EOSQL

CREATE DATABASE ${APPLICATION_DB_NAME};

/* connect to it */

\c ${APPLICATION_DB_NAME};

CREATE TABLE pets (
  id serial primary key,
  name varchar(256)
);

/* Create Application User */

CREATE USER ${APPLICATION_DB_USER} PASSWORD '${APPLICATION_DB_INITIAL_PASSWORD}';

/* Grant Permissions */

GRANT SELECT, INSERT ON public.pets TO ${APPLICATION_DB_USER};
GRANT USAGE, SELECT ON SEQUENCE public.pets_id_seq TO ${APPLICATION_DB_USER};
EOSQL
```{{execute}}

```
CREATE DATABASE
You are now connected to database "quick_start_db" as user "security_admin_user".
CREATE TABLE
CREATE ROLE
GRANT
GRANT
```
