# SQL Basics

SQL is a relational database. Relational databases work using tables of data, that can be "related" between them.
- **Tables** store the data in a strict manner (same data type for each column, same number of columns per row)
- **Data Relations** are the relations we defined between tables. The typical relations we define are One-to-one, One-to-many, and Many-to-many.

## 1 - Basic SQL Commands
### 1.1 the `SELECT` statement
`SELECT` is a basic 'read' SQL statement that allows us to query data. Here are some examples:

```SQL
SELECT * FROM <Tablename>;
```
- Will return all data from the Table entered

```SQL
SELECT <Column1>, <Column2> FROM <Tablename>;
```
- Will return the data in `Column1` and `Column2` (note that the names need to match with an actual column name).

#### Querying unique values
The keyword `DISTINCT` allows us to return unique values in the data
```SQL
SELECT DISTINCT <Columnname> FROM <Tablename>;
```
- Will return the distinct values in the column entered

```SQL
SELECT COUNT(DISTINCT <Columnname>) FROM <Tablename>;
```
- Will count the number of unique values in the column (and return the number)

#### Adding conditions
The `WHERE` statement allows us to introduce boolean conditions to print data according to it.
```SQL
SELECT Column1, Column2 FROM <Tablename> WHERE <Bool-condition>;
```
- Will return all data in `<Column1>` and `<Column2>` in which the `<Bool-condition>` is verified. Typical conditions might be `Column3='String'` or `Column4>100`.

Note: we can use the keywords `AND` and `OR` to aggregate multiple conditions. We can also use `NOT` to demark the opposite of a condition.

List of keywords useable keywords on the `<Bool-condition>`:
- `=`, `>`, `<`, `>=`, `<=`: well known signs
- `<>`not equal (someties written as `!=`)
- `BETWEEN <number> AND <number>`: lets you define a range
- `LIKE`: search for a pattern. `LIKE 'a%'` will return `True` for all strings starting with a letter 'A'.
- `IN ('String1', 'String2')`: returns true if the value is equal to any of the strings
