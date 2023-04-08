# Postgres config

# Configuration

Configuration in Postgres is stored in several files located in the PostgreSQL data directory (`$PGDATA`), they can be edited manually or using utilities such as `pg_ctl` or `pg_config`, or via interacting with the `pg_settings` table.

- `postgresql.conf` contains configuration settings for the PostgreSQL server instance.

- `pg_hba.conf` contains the host-based authentication configuration settings for the PostgreSQL server. 

- `pg_ident.conf` contains mapping rules for mapping PostgreSQL user names to system user names


## Maximum query time

Set the parameter in the `postgresql.conf` file for a general setting, or write it in plain SQL to set the limit on the session level:
```sql
SET statement_timeout = 60000; -- 60 seconds.
```

To setup a per-user statement timeout:
```sql
ALTER ROLE myuser SET statement_timeout = 30000;
```

To check the current default:
```sql
SELECT *
FROM   pg_settings
WHERE  name = 'statement_timeout';
```

## Vacuum

When a row is deleted, Postgres does not remove the record from the database, it marks the column as "dead". These rows are still scanned through in queries as they are still stored. The vacuum process removes these tables

- `VACUUM`. Frees up space from dead rows and marks them as available for new data to be inserted in. It also updates the statistics used by the query planner to make better decisions when executing queries
- `VACUUM FULL`: does everything that `VACUUM` does, but it also reclaims space from the table by moving the live rows to a new location and releasing the space that is no longer needed (this space can be claimed by other tables). More aggressive strategy.

### Configuring autovacuum

Postgres has a process that checks:
1. "Should I vacuum?", and if so, it runs `VACUUM`
2. "Should I analyze?", and if so, it runs `ANALYZE`

The configuration (how often to run these parameters) depends on:
- The amount of data we are dealing with
- The workload of `INSERT`/`DELETE` we are dealing with

Configurations:
- `autovacuum_naptime`: in seconds (default `60s`), how often should Postgres check "should I vacuum"?
- `autovacuum_vacuum_scale_factor`: (default `0.2`) the relative threshold of changed rows that will trigger enabling vacuum
- `autovacuum_vacuum_threshold`: (default `50`) the amount (total) of deleted rows that need to be there to trigger vacuum
- - `autovacuum_analyze_scale_factor`: (default `0.1`) the relative threshold of changed rows that will trigger running analyze
- `autovacuum_analyze_threshold`: (default `50`) the amount (total) of deleted rows that need to be there to trigger re-analysis of the 

> :information_source: If many tables have changed, Postgres will only run `VACUUM` and `ANALYZE` ona subset of the tables to distribute the load.


## Memory configuration

- `shared_buffers`. should be around 15% to 25% of the total RAM
- `work_mem`. Maximum amount of memory that a single query can use; it is set to 4 MB

## CPU



## Storage

- Storage space. Important (obviously), usually auto-scaling enabled. If the storage is full, the DB will go down, and cannot be started again until more storage is made available.
- Storage type. 

## Read replicas

If the read load is much larger than the write one, it pays off having replication enabled.

## Backup and restore

Most cloud providers provide a "point-in-time recovery", which does the following:
- Snapshots are taken in the DB (e.g. every day) - these are taken in the maintenance window
- The WAL is stored in-between snapshots so that the DB can be recovered to a specific point in time

### `pg_dump`

`pg_dump` allows to take snapshots of Databases so that they can be restored.

Take a snapshot:
```sql
pg_dump dbname > backup.sql
```

Restoring it:
```sql
pg_restore -d dbname backup.sql

-- Alternative
psql -d dbname -f backup.sql
```

## Monitoring

Normally we rely on the Cloud providers such as RDS for this.

Otherwise there are open-source projects like:
- [the Postgres prometheus exporter](https://github.com/prometheus-community/postgres_exporter)
- [pghero](https://github.com/ankane/pghero), which will show the
