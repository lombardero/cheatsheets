# Postgres Concepts

- [Postgres Concepts](#postgres-concepts)
- [Posgres objects](#posgres-objects)
  - [Databases](#databases)
  - [Schemas](#schemas)
- [Postgres datatypes](#postgres-datatypes)
  - [Text formats](#text-formats)
  - [Time formats](#time-formats)
    - [Time only](#time-only)
    - [Timestamp](#timestamp)
  - [Boolean](#boolean)
  - [UUIDs](#uuids)
  - [Hstore (not used)](#hstore-not-used)
  - [JSON](#json)
    - [`JSON`](#json-1)
    - [`JSONB`](#jsonb)
  - [User-defined datatypes](#user-defined-datatypes)
    - [Type](#type)
    - [Domain](#domain)
- [Constraints](#constraints)
  - [Datatype constraints](#datatype-constraints)
  - [Key constraints](#key-constraints)
- [Functions \& procedures](#functions--procedures)
  - [Functions](#functions)
  - [Procedures](#procedures)
  - [Triggers](#triggers)
  - [Views](#views)
    - [Regular views](#regular-views)
    - [Materialized views](#materialized-views)


# Posgres objects

## Databases

## Schemas

A schema is a logical grouping of database objects. Inside schemas we have many types of objects including:

- Tables
- Views
- Indexes
- Trigger functions: executes a specific action in response to a specific event, such as an insert, update, or delete operation on a table.
- Aggregates:

# Postgres datatypes

## Text formats

There are three main text data types:

- `CHAR` - A fixed-length character string type that is padded with spaces to the specified length.

  - Ex: a `CHAR(10)` column that is inserted `'hello'` will store `'hello '` (padded with spaces to a total length of 10). Any string longer than 10 characters will be rejected.

- `VARCHAR` - A variable-length character string type that can store up to the specified length.

  - Ex: a `VARCHAR(10)` column inserted with `'hello'` will sto
  -
  - re `'hello'` (without any padding). Any string longer than 10 characters will be rejected.

- `TEXT` - A variable-length character string type that can store an unlimited amount of text data. `TEXT` is generally used for storing large amounts of text data, such as articles, comments, or blog posts.

When to use each:

- Use `CHAR` when you need to store fixed-length strings, such as postal codes or phone numbers, where the length of the string is known in advance.
- Use `VARCHAR` when you need to store variable-length strings, such as user input or email addresses, where the length of the string may vary but still bounded to a limit.
- Use `TEXT` when you need to store large amounts of text data, such as articles, comments, or blog posts.

## Time formats

### Time only

The `TIME` format allows us to store time (without date) with a degree of precision:

- `TIME(0)`: time format with precision up to the second (anything more precise will be truncated)
- `TIME(3)`: time format with the precision up to the milisecond (3 orders of magnitude more precise than second)

### Timestamp

The timestamp format allows us to store date + time. There are two timestamps:

- `TIMESTAMP`: regular UTC timestamp without timezone
- `TIMESTAMPTZ`: timestamp with timezone (this allows Postgres to convert the date to the timezone specified in the session)

> :information_source: Applications should send data in UTC, and let postgres convert it for us.

Setting up a timezone for a session:

```sql
SET TIMEZONE 'Europe/Madrid';
```

## Boolean

Postgres has thuthy and falsy parameters (translated on-the-fly to booleans):

- `TRUE` and `FALSE`
- `'t'` and `'f'`
- `'1'` and `'0'`

## UUIDs

Functions to generate UUIDs:

- `uuid_generate_v1()`: uses MAC address of the device, timestamp and other random values

> :information_source: Although this can be don in Postgres, it is recommended to generate UUIDs in Applications because it is a CPU-intensive operation

## Hstore (not used)

The `hstore` is a key-value pair (not as efficient as JSON) data type that allows storing sets of key-value pairs within a single column. It is useful for storing data that does not fit into the traditional row-and-column structure of a relational database.

> :information_source: This format is not used, as it le

Example:

```sql
-- Inserting:
INSERT INTO my_table (my_hstore_column) VALUES ('key1=>"value1", "key2"=>"value2"');

-- Querying
SELECT my_hstore_column->'key1' FROM my_table;
```

## JSON

Two native JSON datatypes:

### `JSON`

`JSON` is the raw JSON as it was inserted (not optimized for querying). This data type is useful to store data which does not need complex operations on the data

### `JSONB`

`JSONB` is similar to `JSON`, but stores data in a binary format that allows for more efficient querying and indexing. This data type is useful when you need to perform complex operations on JSON data, such as searching or sorting.

## User-defined datatypes

### Type

Types allow new composite or enumerated data types not natively supported. For example, for representing complex numbers, geographical locations, or a custom enumerations.

Examples:

```sql
CREATE TYPE my_type AS (
    name text,
    age integer,
    address text
);
```

### Domain

Domains are useful to add additional constraints or validation rules to existing datatypes. Useful to enforce certain rules on a particular data type, such as limiting the range of values or ensuring that certain properties are always present.

Examples:

```sql
CREATE DOMAIN person_name AS VARCHAR NOT NULL CHECK (value!~ '\s');

CREATE DOMAIN my_domain AS integer CHECK (value >= 0 AND value <= 100);
```

# Constraints

Constraints can be defined for tables and columns.

## Datatype constraints

The `NOT NULL` constraint usually used in `CREATE TABLE` to indicate non-null constraints.

`CHECK`: used in `CREATE TABLE` statement to check for business rules

## Key constraints

`PRIMARY KEY` constraint is used in the `CREATE TABLE` statement to define a primary key.

`FOREIGN KEY` used to spe

Example:

```sql
CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id)
	  REFERENCES customers(customer_id)
```

# Functions & procedures

Functions and procedures allow us to encapsulate a series of SQL statements (available to the users).

The difference between both:

- Functions return something (procedures not)
- Functions can be called as part of a query (procedures not)
- Functions cannot use transactions (procedures can)

> :thought_balloon: In the past, a lot of business logic was stored in the database. Nowadays, this logic has been moved as much as possible in the application layer. This is much more scalable (much harder to do on the DB side). Hence, **using functions & procedures** should be done with care. Think about scaling the application always!

## Functions

Function syntax
```sql
create [or replace] function function_name(param_list)
   returns return_type
   language plpgsql
  as
$$
declare
-- variable declaration
begin
 -- logic
end;
$$
```

> :information_source: We usually define a custom type for functions:
> 1. `CREATE TYPE ...`
> 2. `CREATE OR REPLACE FUNCTION ...`

## Procedures

Syntax:

```sql
create [or replace] procedure procedure_name(parameter_list)
language plpgsql
as $$
declare
-- variable declaration
begin
-- stored procedure body
end; $$

```

Example:

```sql
create or replace procedure transfer(
   sender int,
   receiver int,
   amount dec
)
language plpgsql
as $$
begin
    -- subtracting the amount from the sender's account
    update accounts
    set balance = balance - amount
    where id = sender;

    -- adding the amount to the receiver's account
    update accounts
    set balance = balance + amount
    where id = receiver;

    commit;
end;$$
```

## Triggers

Triggers allow us to execute some SQL statements (such as a function :bulb:) when something happens.

```sql
-- Defining the trigger logic
CREATE OR REPLACE FUNCTION function() RETURNS TRIGGER AS
$$
    BEGIN
        -- Trigger body
    END;
$$ LANGUAGE plpgsql;

-- Creating the trigger
CREATE TRIGGER trigger_name AFTER INSERT ON TABLE
FOR EACH ROW EXECUTE PROCEDURE function();
```

> :question: The sintax above is correct, we `CREATE FUNCTION` but `EXECUTE PROCEDURE` :thinking_face:

## Views

### Regular views

A view is a pseudo-table in Postgres. In the background, the view is simply a query that is run every time the view is accessed (as performant as running the query yourself). The main advantage is to not need to expose the logic

### Materialized views

Materialized views are an extension of views which caches the results of a query in disk for performance gains.

```sql
CREATE MATERIALIZED VIEW view_name
AS
<query>
WITH [NO] DATA;
```
- `WITH [NO] DATA`: the materialized view is created without data (will be only added when we `REFRESH` it)
- `WITH DATA`: the data is added at creation time

Refreshing the data:
```sql
REFRESH MATERIALIZED VIEW view_name;
```
