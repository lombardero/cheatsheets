# SQLAlchemy

`SQLAlchemy` is one of the most broadly-used ORM libraries to connect Python scripts with SQL-like databases such as MySQL, Postgres or data warehouses like Snowflake.

# 1 - Basic concepts


# 2 - Connecting, executing queries
## 2.1 - DB engine
### 2.1.1 Creating an engine
The `engine` is the basic object required to establish a connection with a database, it stores the DB URL and all the credentials required to access it. After it is instantiated, a `connection` can be established to the DB through it (which will allow us to query or transact with it).

> Note: creating an engine will not actually connect to the DB until we run the `connect` statement.

Example of engine creation for a `mysql` database:
```python
engine = create_engine('mysql://john:lennon@localhost/foo')
```
Now that the engine is created, we can start executing queries and transactions to the DB.

### 2.1.2 Useful methods

#### Querying all table names
```python
print(engine.table_names())
```
- Will return all table names available in current engine.
