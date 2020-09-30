
The application we’ll be deploying is a [pet store demo application](https://github.com/conjurdemos/pet-store-demo) with a simple API:

- `GET /pets` lists all the pets
- `POST /pet` adds a pet
Its PostgreSQL backend is configured using a `DB_URL` environment variable:

```
postgresql://localhost:5432/${APPLICATION_DB_NAME}?sslmode=disable
```

Again, the application has no knowledge of the database credentials it’s using.

For usage examples, please see [Test the Application](https://secretless.io/tutorials/kubernetes/app-dev.html#test-the-application
)
