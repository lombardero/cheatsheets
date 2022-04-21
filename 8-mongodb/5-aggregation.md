# Aggregation framework

Companies have started moving the complexity from the Database to the application (logic = procedures stored in the Database). The reason is that databases are hard to scale once they have reached their limit, whereas applications can be easily expanded.

This applies to the Aggregation framework as well. It is a powerful tool, but should not be overused because it adds complexity in the DB layer.

# Aggregation

The aggregation framework allows us to create data processing pipelines that take collections and generate an output.

These aggregations are done by stages, and work with operators:
- `$match`: same as [`find()`](2-mongosh.md#querying-with-find), will select all data that satisfies a query (in the same way as it would work in [`find()`](2-mongosh.md#querying-with-find)
- `$project`: select certain fields, works the same as projections in [`find()`](2-mongosh.md#projections)
- `$sort`: sort results, works the same as [`sort()`](2-mongosh.md#sorting-results)
- `$limit`: limit number of results. Example: `{$limit: 5}`
- `$group`: group by

> See the official [aggregation documentation](https://docs.mongodb.com/manual/aggregation/).

## Syntax

Aggregations are done through computation steps, which are introduced as comma-separated key-value pairs with the operator and the query.

```
> db.collections.aggregate(
    { <operator1>: <query1>},
    { <operator2>: <query2>}
)
```

Example:
```mongo
db.movies.aggregate([
   {$match: {languages: "Spanish"}},
   {$project: {languages: 1, title: 1}}
]
)
```
- Select all movies in Spanish, and show all the languages it has and its title

### Grouping results

The `$group` operator works in a simular fashion as the `GROUP BY` operator in SQL.

> See official [`$group` documentation](https://docs.mongodb.com/manual/reference/operator/aggregation/group/#mongodb-pipeline-pipe.-group).

```
> db.collection.aggregate(
    [
        $group: {
            _id: <expression to group by for>,
            aggregated_field: {<aggregation function>: <sum expression>}
        }
    ]
)
```
- Aggregates based on the expression:
  - Can be the name of a field such as: `"$field_name"`)
  - Can be a set of fields such as `{field1: "$field1", field2: "$field2"}`

Aggregation functions:
- `$sum`: counts all results aggregated. Can be used to:
  - Count all fields falling in that aggregation: `1`
  - Count number of nested subfields in that aggregation: `$subfield_name` (example, count number of comments while grouping by movie year)
- `$push`: aggregate elements on a list
- `$unwind`: will create one record (document) for each item of a list rather than keeping it grouped. 
- `$lookup`: same as SQL `JOIN`, allows to group data from other collections


### Sorting

Example of sorting:
```
> db.movies.aggregate(
    [
        { $group: {
            _id: "$year", 
            number_movies: { $sum: 1 },
            num_comments: { $sum: "$num_mflix_comments"},
            movies: { $push: "$title" } 
            } 
        }
    ]
)
```

### Aggregation

Example of lookup in another collection:
```
> db.orders.aggregate(
    [
        {
            $lookup:
            {
                from: "inventory",
                localField: "item",
                foreignField: "sku",
                as: "inventory_docs"
            }
        }
    ]
)
```
