# Postgres Architecture

- [Postgres Architecture](#postgres-architecture)
- [Background processes](#background-processes)
- [Memory usage](#memory-usage)
- [Postgres design choices](#postgres-design-choices)
  - [Inheritance](#inheritance)
  - [Multi-Version Concurrency Control (MVCC)](#multi-version-concurrency-control-mvcc)


# Background processes

This is what happens when we interact with postgres:
- We want to run a query, Postgres reads the data -currently on disk- into memory so that we can interact with it
- When a query is executed, the **writer** changes are updated in memory (in a structure called _dirty buffer_), AND a copy of the command run is saved in the Write-ahead-log by the **WAL writer**

Postgres runs a series of separate background processes that make sure the data is persisted in disk, the memory size and WAL stays manageable:
- the **Checkpointer Process** writes the content of the dirty buffer into disk (happens every ~60 seconds)
- the **Autovacuum Process** recovers free memory space (contents of the dirty buffer that were persisted)
  - This process also runs the **Analyzer** (Stats update) whenever Postgres considers the table sizes have been changed (every 60 seconds, it checks if some thresholds of records inserted / tuples changed were supassed, then it runs "analyze") 
- the **Logger** writes messages (usually only the errors) to the log file
- the **Archiver** -if the option is enabled- archives the 
- the **Stats Collector** collects statistics about tables (storing session execution info in `pg_stat_activity` and table usage info `pg_stat_all_tables`). These statistics are then used to build query plans

> :bulb: It is considered good practice to run the `ANALYZE` statement after a big change is done in the Database. 

# Memory usage

The memory usage is divided in two Blocks:
- The Background process memory (loaded)
  - `work_mem`: the Execturor uses this area for sorting rows by `ORDER BY`
  - `maintenance_work_mem`: for Maintenance operations (e.g. `VACUUM`, `REINDEX`)
  - `temp_buffers`: Executor uses this are to store temporary tables

- The Shared memory area:
  - Shared buffer pool: Postgres loads a copy of the data stored in disk here, with tables and indexes. This is also referred as "dirty buffers". When a query is exectuted, this is what is modified.
  - WAL buffer: the WAL buffer stores statements to be written to the WAL here until the WAL writer picks it up
  - Commit Log: The commit lg keeps the stat

# Postgres design choices

## Inheritance

Postgres inheritance allows you to create a new table that inherits all the columns and attributes of an existing table. This can save you time and effort, as you only need to define the common structure once.

For example:
```sql
-- Parent table
CREATE TABLE cities (
    name        text,
    population  real,
    elevation   int
);

-- Child table
CREATE TABLE capitals (
    state       char(2) UNIQUE NOT NULL
) INHERITS (cities);
```

## Multi-Version Concurrency Control (MVCC)

MVCC is a technique used by Postgres to allow multiple transactions to access the same database objects concurrently without conflicting with each other. 

It works by creating multiple "versions" of each row in a table, with each version representing the state of the row at a specific point in time. When a transaction reads a row, it reads the version of the row that was current at the time the transaction started. If another transaction modifies the row while the first transaction is still running, the second transaction creates a new version of the row with the updated data, while the first transaction continues to read the original version.

Benefits of MVCC:
- Better efficiency for concurrent transactions
- High-availability: MVCC allows reducing the use of locks


