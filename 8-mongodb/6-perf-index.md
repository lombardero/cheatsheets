# Performance and Indexing

(check video)

Indexes in MongoDB are structured files that save pointers to documents in a structured
binary-tree structure. If MongoDB can use an index for a document, it will go to the
file directly and retrieve that document.

# 1 - Query plans

MongoDB introduces an `explain()` function which will output how the command will be
executed.

```sh
<query>.explain()
```

## Best practices

- Use compound indexes whenever possible
- Follow the ESR rule as much as possible
- Use Covered queries (projecting fields rather than selecting all fields)
- Performance is optimal for indexes on high-cardinality fields, use indexes for such
  fields (unless we plan on querying on a given field very often)
- Delete unnecessary Indexes
- Use Partial Indexes when possible (they are lightweight)
- Make sure indexes fit in the RAM.
  - Note that there is no way to calculate the index size, we can use `db.collection.stats()` to check the size of the collection and its indexes: `size`, `storageSize` (compressed one), `totalIndexSize` and `indexSizes`. If `totalIndexSize` fits in memory, that is great, but `totalSize` is the most performant.

## Partial indexes

Partial indexes allow us to create an index in given filters for a collection that we
plan on using often, so the data can be accessed faster.

```
db.restaurants
```

For partial filters, we can use:
- `$gt` or lower
- `$exists`
- 

## TTL indexes

TTL Indexes are special single-field indexes that can be set up in MongoDB to delete
certain documents based on a timestamp field. MongoDB will run a process that checks
regularly if the timestamp of the field is older than the expiration
condition, and if so, it deletes the document.

> Note: they only work as single-field indexes

```
db.eventlog.createIndex(
    { "lastModifiedDate": 1 },
    { expri }
)
```
- Delete the record if the `lastModifiedDate` field is older than `5` seconds.

