# SQL Basics

SQL is the language for manipulating and querying relational databases.

Relational databases work using tables of data, that can be "related" between them.
- **Tables** store the data in a strict manner (same data type for each column, same
  number of columns per row)
- **Data Relations** are the relations we defined between tables (typically achieved
  by having the primary key of one table in another, so that they can be joined).
# 1 - Selecting data

There are two basic statements for selecting data in SQL:
- `SELECT`: will select the provided columsn
- `FROM`: will select the table(s) needed for the query

For example, one of the most basic SQL statements is to select all columns form the
a table:

```SQL
SELECT *
FROM my_table;
```
- Will return all data from the Table entered


```SQL
SELECT column_one, column_two
FROM my_table;
```
- Will return all rows in `column_one` and `column_two`

## 1.3 Filtering rows

The `WHERE` statement allows us to introduce boolean conditions select rows accordingly.

Let's for example select all rows that do not contain a `NULL` status on `my_table`:

```SQL
SELECT column_one, column_two
FROM my_table mt
WHERE mt.status IS NOT NULL;
```
- Will return all data in `column_one` and `column_two` from `my_table` in which the
  column `status` is not null. Other typical conditions might be `column_three='String'`
  or `column_four>100`.

> Note: we can use the keywords `AND` and `OR` to aggregate multiple conditions. We can
> also use `NOT` to demark the opposite of a condition.

### Boolean conditions in SQL

List of keywords useable keywords on the `<Bool-condition>`:
- `=`, `>`, `<`, `>=`, `<=`: well known signs
- `<>`not equal (someties written as `!=`)
- `BETWEEN <number> AND <number>`: lets you define a range
- `LIKE`: search for a pattern. `LIKE 'a%'` will return `True` for all strings starting
  with a letter 'A'.
- `IN ('String1', 'String2')`: returns true if the value is equal to any of the strings


# 2 - Joining tables

Joining tables is required to obtain data that is spead across multiple tables.
There are several types of joins:
- `INNER JOIN`: Selects ONLY the data from both tables matching a given condition
- `RIGHT JOIN`: Keeps the table of the "right" (on the SQL command) unchanged, adding
  the extra data from the "left" table (if available) in another column. This join makes
  sure that the right table data is not lost.
- `LEFT JOIN`: Same as a right join but keeping the left data.
- `FULL OUTER JOIN`: The combination of a `LEFT JOIN` and a `RIGHT JOIN`: the data
  from both tables is kept, and rows are combined when possible.

## 2.1 `INNER JOIN`

Inner joins are very useful to obtain data from a table (usually with a specific
goal). Let's visualise it with an example.

Let's assume we work for a University and have the following tables:
- `Students`: columns `id` (primary key), `name`, `last_name`
- `Courses`: columns `id` (primary key), `name`, `professor`
- `Course_Subscriptions`: matching `course_id` and `student_id`

Now, if we want to know which students enrolled a given course, or which courses
were enrolled by a given student, we need the information across several tables.
For that, we use an `INNER JOIN`:

Getting the Courses enrolled by student with `id = 123`
```sql
SELECT s.name, s.last_name, c.name
FROM students s, courses c, course_subscriptions cs
    INNER JOIN s.id = cs.student_id
    INNER JOIN c.id = cs.course_id
    WHERE s.id = 123;
```
- We need to join three tables (hence, two inner joins) to get the data from both
  elements.

# 3 - Aggregating results

## 3.1 `GROUP BY`

`GROUP BY` allows to aggregate results into one row given a category. It is added
after the `WHERE` clause, and can be considered as a "post-processing" statement.

Following our previous example of `Students` and `Courses`, we can use the `GROUP BY`
statement to count the number of students registered by course, or the number of
courses that each student enrolled into:

```sql
SELECT c.name, COUNT(s.id)
FROM students s, courses c, course_subscriptions cs
    INNER JOIN s.id = cs.student_id
    INNER JOIN c.id = cs.course_id
    GROUP BY c.name;
```
- Returns a table with the number of students by course name (see that we aggregated
  the data by `c.name`)

> Note: to display the total count of students, we used the aggregation function
> `COUNT`, which aggregated the data associated with each `c.name`.

### Aggregation functions

SQL has several aggregation functions built-in, here are some:
- `COUNT()`: returns the total count of instances per aggregated field
- `MAX()`: returns the max value per aggregated field
- `MIN()`: returns the min value
- `SUM()`: returns the sum of all instances aggregated
- `AVG()`: returns the mean of all instances aggregated

## 3.2 Aggregating by `DISTINCT` values

The keyword `DISTINCT` (placed after `SELECT` allows SQL to aggregate the data by unique
row values.

It can show all distinct values from a given column:

```SQL
SELECT DISTINCT column_one
FROM my_table;
```
- Will aggregate rows by distinct values of `column_one`

And count the number of instances:

```SQL
SELECT COUNT(DISTINCT column_one)
FROM my_table;
```
- Counts the number of unique values in the `column_one` and outputs it

> Note: `DISTINCT` is not as powerful as `GROUP BY`, and is only executed with the
> `SELECT` statement, see [SQL execution](#5---sql-execution)

# 5 - SQL execution

In SQL, the order of execution of statements is nor from top to bottom,
it actually fopllows the below order:
1. `FROM`: first, SQL selects the tables that are required for the query, and
sets up aliases for them
2. `JOIN`: performs the required joins, one-at-a-time, given the provided conditions
3. `WHERE`: selects the rows matching the provided condition
4. `GROUP BY`: aggregates the remaining data based on the condition (if any `HAVING`
clause is specified, it is executed afterwards)
5. `SELECT`: Selects the given columns to display
6. `ORDRER BY`: orders the output
