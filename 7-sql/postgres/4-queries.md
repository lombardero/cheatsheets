# Postgres Queries

- [Postgres Queries](#postgres-queries)
- [Joins](#joins)
  - [Inner Join](#inner-join)
  - [Left \& Right Joins](#left--right-joins)
  - [Outer Join](#outer-join)
  - [Cross Join](#cross-join)
  - [Natural join](#natural-join)
  - [Self join](#self-join)
- [`JSONB` operators](#jsonb-operators)
- [Recursive](#recursive)
  - [Recurstive CTE](#recurstive-cte)
- [Transaction management](#transaction-management)
  - [Isolation level types](#isolation-level-types)
  - [Setting isolation levels](#setting-isolation-levels)
- [Locks](#locks)
  - [Table level locks](#table-level-locks)
  - [Row-level locks](#row-level-locks)

# Joins

## Inner Join

Returns all rows from both tables that match the join condition. It is the most commonly used join.

## Left & Right Joins

Also known as `LEFT OUTER JOIN` and `RIGHT OUTER JOIN`, returns all rows from the left/right table and the matching rows from the other one. If there is no matching row in the right table, NULL values are returned.

## Outer Join

Also known as `FULL OUTER JOIN`, returns all rows from both tables and NULL values where there is no match.

## Cross Join

Returns the Cartesian product of both tables, which is all possible combinations of rows between the two tables. It does not require a join condition.

Useful, for example, if we have a "date" table with all possible dates, and "location" table with all locations, to get all the combinations of "date - location" possible.

## Natural join

Returns all rows from both tables where the column names match, and it does not require a join condition. This type of join can be risky because it may produce unexpected results if the column names are not unique or if the tables have different column names.

## Self join

A table can be joined with itself. This is useful when you want to compare rows within the same table.

# `JSONB` operators

- `->`: extracts a specific JSON element, returning the value as JSON (array).
- `->>`: extracts a specific JSON element, returns the value as text.
- `#>`: extracts a JSON sub-array from a JSON object. It returns the sub-array as JSON.
- `#>>`: extracts a JSON sub-array from another JSON object. It returns the sub-array as text.
- `@>`: checks if a JSON contains another JSON as sub-array.
- `<@`: checks if a JSON is a sub-object or sub-array of another one.
- `?` : checks if a JSON contains a specified key.
- `?&`: checks if a JSON contains all specified keys.
- `?|`: checks if a JSON contains any of the specified keys.
- `||`: concatenates two JSON arrays into a single one.

Examples:

```sql
SELECT '{"name": "John", "age": 30}' -> 'name';
-- Will return "John"

SELECT '{"person": {"name": "John", "age": 30}}' #> '{person}';
-- Will return {"name": "John", "age": 30}} - if we used -> would return 'null'
```

# Recursive

## Recurstive CTE

A recursive common table expression (CTE) is a query that refers to itself in a recursive manner. It is a powerful tool for querying hierarchical data, such as organization charts or nested categories.

It uses the `WITH RECURSIVE` syntax, which specifies the initial query and the recursive query. The initial query is executed once to generate the initial set of rows, while the recursive query is executed repeatedly to generate additional rows that are added to the result set.

Syntax:

```sql
WITH RECURSIVE cte_name AS(
    CTE_query_definition -- non-recursive term
    UNION [ALL]
    CTE_query definion  -- recursive term
) SELECT * FROM cte_name;
```

Example:

```sql
-- We have a list of employees
 id | name  | manager_id
----+-------+-----------
  1 | Alice | null
  2 | Bob   | 1
  3 | Carol | 1
  4 | Dave  | 2

-- We want to get each person's manager (starting from the CEO)
WITH RECURSIVE employee_hierarchy(id, name, manager_name) AS (
  SELECT id, name, null::text as manager_name FROM employees WHERE manager_id IS NULL
  UNION ALL
  SELECT employees.id, employees.name, employee_hierarchy.name FROM employees
  JOIN employee_hierarchy ON employees.manager_id = employee_hierarchy.id
)
SELECT name, manager_name FROM employee_hierarchy ORDER BY id;

-- Result:
 name  | manager_name
-------+-------------
 Alice |
 Bob   | Alice
 Carol | Alice
 Dave  | Bob
```

- We start by defining the recursive CTE `employee_hierarchy` with three columns: `id`, `name`, and `manager_name`. The first query inside the CTE is the initial query that selects the CEO (`manager_id` is `null`) and sets the `manager_name` to `null.
- The second query is the recursive one that joins the employees table to itself using the `manager_id` and `id` columns. We also join with the `employee_hierarchy` CTE to retrieve the `manager_name` for each employee's manager.
- The `UNION ALL` keyword combines the initial and recursive queries.
- We finally select the `name` and `manager_name` columns from the `employee_hierarchy` CTE, ordered by the `id` column.

# Transaction management

## Isolation level types

Before introducing isolation levels, we need to talk about the 3 main types of transaction anomalies -as isolation types will define which anomalies are prevented:

- **Dirty reads**. Occurs when a transaction reads uncommitted data that has been modified by another transaction. This can result in inconsistent and incorrect data being read.

- **Non-repeatable reads**.A non-repeatable read occurs when a transaction reads the same data twice and gets different results because another transaction has modified the data in between the reads. This can also result in inconsistent and incorrect data being read.

- **Phantom reads**. They occur when a transaction reads a set of rows that satisfy a certain condition, but when it re-reads the same rows later in the transaction, additional rows have been inserted or deleted by another transaction, causing the initial read to "phantom" additional rows.

## Setting isolation levels

Isolation levels determine how much locking and blocking occurs during reads and writes. These can be modified by running:
```sql
SET TRANSACTION ISOLATION LEVEL <isolation_level>;
```
- The default one is `READ COMMITTED`

The isolation levels in Postgres are:

- `READ COMMITTED`. Prevents dirty reads, allowing the rest. It provides good concurrency by allowing concurrent reads and writes. This is the default setting, and considered good practice because it provides a good balance between concurrency and data consistency, and is generally sufficient for most applications.
- `REPEATABLE READ`: Prevents dirty reads and non-repeatable reads, allowing phantom reads only. Use this isolation level if your application requires stronger data consistency guarantees. It provides less concurrency than `READ COMMITTED` because it requires locks to be held for the duration of the transaction.
- `SERIALIZABLE`: Prevents all read anomalies, but can be slower and more restrictive due to the increased locking and blocking that it requires. Even more data consistency than `REPEATABLE READ`, and even less concurrency: it requires locks to be held for the whole transaction and may cause more blocking and deadlocks.
- `READ UNCOMMITTED`: Allows all anomalies. Not supported in Postgres.

# Locks

Postgres supports table locks, and row locks. See the [official documentation](https://www.postgresql.org/docs/current/explicit-locking.html).

## Table level locks

- `SHARE`: 
  - Allows: other transactions to read & acquire `UPDATE` and `SHARE` locks
  - Prevents: concurrent data changes
  - Used by: `CREATE INDEX` (without `CONCURRENTLY`)
- `ACCESS SHARE`: the  `SELECT` statement acquires this lock
  - Allows: reads and locks by other transations
  - Prevents: edits on the table
  - Conflicts with: `ACCESS EXCLUSIVE` lock only
  - Useful for: allowing concurrent reads from a table while preventing row-level locks that could block access to the table.
- `EXCLUSIVE`:
  - Allows: `ACCESS SHARE` locks only (`SELECT` statements) by other transactions
  - Prevents: all the rest
  - Used by: `REFRESH MATERIALIZED VIEW CONCURRENTLY`
- `ACCESS EXCLUSIVE`: this mode is the most restrictive, making sure the current transaction is the only that can access the table in any way.
  - Allows: nothing
  - Prevents: everything (locks & operations)
- `SHARE UPDATE EXCLUSIVE`:
  -  Allows: reads
  - Prevents: concurrent schema changes and `VACUUM` runs
  - Used by: `VACUUM` (without `FULL`), `ANALYZE`, `CREATE INDEX CONCURRENTLY`, `CREATE STATISTICS`, `COMMENT ON`, `REINDEX CONCURRENTLY`, and certain `ALTER INDEX` and `ALTER TABLE` variants

## Row-level locks

- `ROW EXCLUSIVE`:
  - Allows: reads in the row 
  - Prevents: row modifications by other transactions
  - Used by: `UPDATE`, `DELETE`, `INSERT`, and `MERGE` acquire this lock mode on the target table (in addition to `ACCESS SHARE` locks on any other referenced tables). In general, this lock mode will be acquired by any command that modifies data in a table.

- `SHARE ROW EXCLUSIVE`
  - Allows: concurrent reads
  - Prevents: Concurrent data changes & any other locks in the row
  - Used by: `CREATE TRIGGER` and some forms of `ALTER TABLE`.

