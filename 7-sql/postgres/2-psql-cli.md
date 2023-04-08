# Postgres CLI

- [Postgres CLI](#postgres-cli)
- [`psql`, the Postgres CLI](#psql-the-postgres-cli)
- [`pgadmin`, the Postgres Management application](#pgadmin-the-postgres-management-application)


# `psql`, the Postgres CLI

Try `psql` commands locally:
```sh
# Run Postgres
docker run --name postgresql -p 5432:5432 -e POSTGRES_PASSWORD=mypassword -d postgres
# Open an interactive shell inside the container
docker exec -it <container_id> /bin/bash
# Connect to Postgres using the CLI
psql -h localhost  -p 5432 -U postgres
```


# `pgadmin`, the Postgres Management application

PgAdmin is an application that provides a frontend allowing us to manage our Postgres instances.

It provides, among others:
- Connection management: manage multiple PostgreSQL database connections.
- SQL editor:integrated SQL editor with syntax highlighting, code completion & more.
- Object browser: hierarchical view of the database objects, such as tables, views, indexes, and functions.
- Query tool: query tool with support for executing SQL queries, viewing query results, and exporting data in various formats.
- Backup and restore: backup and restore interface for PostgreSQL databases.
- Job scheduler: Ischedule and automate routine database tasks using the built-in job scheduler.


Try out PgAdmin (use it to register a Postgres instance):
```bash
docker pull dpage/pgadmin4:latest
# Running PgAdmin
docker run --name pgadmin -e "PGADMIN_DEFAULT_EMAIL=name@example.com" -e "PGADMIN_DEFAULT_PASSWORD=admin" -p 5050:80 -d dpage/pgadmin4
# Then, pgadmin should be running in http://localhost:5050/
```
