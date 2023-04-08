# Optimization

- [Optimization](#optimization)
- [Query optimization](#query-optimization)
  - [`EXPLAIN` queries](#explain-queries)
  - [Cost computation](#cost-computation)
  - [Indexes](#indexes)
  - [Algorithms](#algorithms)
    - [Scan types](#scan-types)
    - [Joins](#joins)
  - [Table partitioning](#table-partitioning)
    - [The `pg_partman` extension](#the-pg_partman-extension)
  - [Bulk loads](#bulk-loads)
    - [Tips to use bulk loads efficiently](#tips-to-use-bulk-loads-efficiently)
  - [Performance tips](#performance-tips)
    - [Indexing](#indexing)
    - [Force join orders](#force-join-orders)
    - [Avoid expensive statements](#avoid-expensive-statements)

We can use [Dalibo](https://explain.dalibo.com/) to visualize query plans.

# Query optimization

## `EXPLAIN` queries

`EXPLAIN` will use the postgres stats to explain how postgres plans to execute (without doing so) a query. It will mention:

- The type of scans used: index / sequential, etc.
- The tables used
- The join algorithms used

Using `EXPLAIN ANALYZE`, the query will be executed and

## Cost computation

Postgres assigns a "cost" to statements, which has an arbitrary unit that allows postgres to compare strategies for each.

## Indexes

Indexes can be created for single columns or multiple columns, based on how we intend to query the data.

- Pros: they speed-up queries
- Cons: they need to be stored, each read operation is costlier

> :information_soruce: Multi-column indexes only work in the same order.

## Algorithms

### Scan types

Postgres will decide which type of scan it will do, based on the available indexes and the stats of tables, Postgres will decide weather it does any of these scans:

- **Sequential scan**. Reads each row in the order it appears on disk. Used when there is no index available or when the query needs to retrieve a large portion of the data in the table.

  - Useful for: unusual queries or queries filtering a small subset of the data

- **Index scan**. Uses an index to retrieve data from a table, which identifies the rows that match the query, which then are retrieved from the table.

  - Useful for: queries filtering a large subset of the data

- **Index only scan**. Similar to an index scan, but it avoids loading the whole row. Instead, all the required columns are present in the index itself, so the index is used to retrieve the data directly.

  - Useful for: frequent queries filtering a large subset of the data that need a small subset of the columns

- **Bitmap scan**. Efficiently retrieves data from a table combining multiple indexes. A "bitmap" is a set of bits that represent the presence or absence of rows that satisfy a particular condition. This is then used to retrieve the data efficiently.
  - Useful for: using multiple indexes (e.g. 2 `WHERE` clauses based on data using 2 different indexes), or when queries filter a larger set of the data

To optmize a query, we can check what type of scan is done, and how it could be improved.

### Joins

- **Nested loop join**. The simplest and most basic join algorithm in PostgreSQL. It is used when one of the tables being joined is small. The smaller table is looped through and each row is matched against the rows in the larger table. It can be relatively slow when the larger table is really large, but it has the advantage of not requiring much memory.
- **hash join** Hash Join is a type of join algorithm used in PostgreSQL to join large tables efficiently. It involves creating a hash table of the smaller table and then probing it with the larger table. The hash table is usually small enough to fit into memory, which makes this join very efficient. Preferred strategy if the hash table fits in memory (`work_mem`).
- **Merge join**. Used when both tables being joined are already sorted on the join columns. It works by comparing the first row from each table and then advancing through each table, comparing the next row until all matching rows are found. This join algorithm is faster than Nested Loop Join, but slower than Hash Join.

Postgres checks the "cost" of each of these queries and will select the one promising the lowest cost.

## Table partitioning

Partition is a technique to divide a large table into smaller, more manageable pieces called partitions, based on a partition key. Each partition is a separate table, but together they form a single logical table.

For example, if we often select tables based on the year, we can use the year as partitioning key, so that Postgres does not need to scan through all the other data.

> :bulb: It is one of the most effective tools for speeding-up queries, however, it requires careful design

> :information_source: The main data file for a table is stored in a subdirectory of the PostgreSQL data directory, typically located in /var/lib/postgresql/data on Linux systems. The data file consists of a series of fixed-size pages, each containing a set of rows from the table. Each row is stored as a sequence of bytes, with each column in the row occupying a fixed amount of space depending on its data type and size.

PostgreSQL supports two types of partitioning:

- **Range Partitioning**. Divides a table into partitions based on a range of values. For example, we can partition a table by month or year. Range partitioning is useful for time-series data, where data is frequently queried by a date or time.
- **List partitioning**. Divide the data on non-overlapping set of values. For example, partitioning the data per country. This allows for more control over the distribution of data across partitions and can be useful for scenarios where data needs to be grouped together based on specific values.
- **Hash Partitioning**. Divides a table into partitions based on the hash value of the partition key. The hash function evenly distributes rows across partitions, so the size of each partition is roughly the same. Hash partitioning is useful for load balancing and distributing data across multiple servers.

> :thought_balloon: Partitions are useful for "large" tables, where indexes become too big to bring in a substantial advantage (e.g. when it does not fit in memory). A rule-of-thumb is: partition when the table size is an order of magnitude the size of your memory.

> :thought_balloon: Always, always test your improvements.

### The `pg_partman` extension

`pg_partman` (:octocat: [here](https://github.com/pgpartman/pg_partman)) allows to simplify partition management through configuration. It enables:
- Autmatic partition creation: partitions are automatically created based on an interval or value range
- Retention policies: old partitions are automatically dropped or archived
- Parallel partitioning: partitions can be created and managed in parallel

## Bulk loads

The quickest way to import large amounts of data into a Postgres database. For bulk loads, use the `COPY` command (much more efficient than `INSERT`, which does it for each row)

### Tips to use bulk loads efficiently

- Disable `INSERT` triggers if we defined any
- Run `ANALYZE` right after the bulk load to keep the statistics updated

## Performance tips

### Indexing

- **Index foreign keys**. Primary keys are indexed by default; indexing foreign keys can also improve the efficiency quite a bit.

> :thought_balloon: remember that indexes trade read speed by write speed

### Force join orders

To reduce planning time, we can explicitly mention the query order to reduce planning time. We can do so by adding parenthesis

### Avoid expensive statements

- `SELECT *`. Avoid loading data where is not needed
- `ORDER BY`. Very expensive to do. If it cannot be done in memory, this will be even slower -it will need to do this in the disk-. This statement needs to be used with care.


