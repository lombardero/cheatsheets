# Mongo

#

To work with mongo, we need to install:
- Mongo CLI: `mongosh`

`mongosh` (`brew install mongosh`)

```sh
$ mongosh
```
- Enter the mongo shell

This will enable to open the database

## Mongo shell commands

```mongo
> show dbs;
```
- Show all the databases available

```mongosh
> use <database name>
```
- Select one database

```mongodb
> show collections;
```
- Once a database is selected, this command shows the available collections on that database

# Running commands in the database

When inside a database (after using `use <database name>`): `db` is a special vairable which enables us to interact with the database.

# Querying with `find`

```
> db.<collection>.findOne()
```
- Returns the first document of the database (useful to take a look a document structure of that collection)


Querying by field
```
> db.<collection>.find({field_name: <target value>})
```
- Find all documents from a collection which has a special field

Querying by subfield
```
> db.<collection>.find({"field_name.subfield_name": <target value>})
```
> Note: querying by subfield requires using double quotes

Querying by item of a list
```
> bd.collection.find({list_name: <target value>})
```
- Will return all documents with that target value


## Querying operators

Operators starts with a dollar sign.

Greater than ($gt`)
```
db.collection.find({field_name: {$gt: <target value>}})
```

In (`$in`):
```
db.collection.find({field_name: {$in: [value1, value2]}})
```
- Returns all fields satisfying the "in" condition (have either `value1` or `value2`)

Other operators:
- `$eq`
- `$gt`: greater than. In arrays, it will return all documents with at least one of the arrays verifying this condition.
- `$gte`
- `$in`
- `$lt`
- `$not`

## Combining queries

AND operand: using two different fields in the query
```mongodb
> db.collection.find({field_name1: value1, field_name2: value2})
```
- Will work as an "and" -> get all fields satisfying the above condition

OR operand: using the same field in the query
```
> db.collection.find({field_name: value1, field_name: value2})
```

To use an OR condition with different fields:
```
> db.collection.find("$or": {field_name1: value1, field_name2: value2})
```

## Sorting results

```
> db.collection.find(<query>).sort({field_name: 1})
```
- Use `-1` for reverse order

Combine sortings:

```
> db.collection.find(<query>).sort({field_name1: 1, field_name: -1})
```
- Order by field name 1 first, then the second one


## Counting results

```
> db.collection.find(<query>).count()
```

## Skipping results and limiting
```
> db.collection.find(<query>).limit(n)
```
- Limit results to `n` fields
- 
```
> db.collection.find(<query>).skip(m)
```
- Skip the `m` results of the query

## Null fields

In MongoDb, `null` is considered a value that we do not know the value from. It will
be treated always as a field that might have that information. Meaning, null values will always be part of the
query results

Querying nulls:
```
db.collection.find({field_name: {$type: "null"}})
```
> Note: in MongoDB, `null` is a data type

Querying for documents which do not have a field defined:
```
db.collection.find({field_name: {$exists: false}})
```

## Projections

Projections are the `SELECT` equivalent in MongoDB. It is used to define the fields that we are interested from.

```
> db.collections.find(<query>, {field1: 1, field2: 1})
```
- Will show fields 1 and 2 from the query results

```
> db.collections.find(<query>, {field3: 0})
```
- Will show all fields except field 3

We can also rename and create new fields:
```
> db.collection.find( <query>, {
               name: "$title", 
               awards: "$awards.wins",
               size_cast: {$size: "$cast"}
               }
            }
            )
```
- In this function call we:
  - rename `title` field to `name`
  - get the `awards.wins` as `awards`
  - use the `$size` operator to compute the size of the `cast`


## Aggregation: Creating new fields

Projections allow us to create new fields in the results:

```
> db.collections.find(<query>, {field1: 1, field2: 1, new_field_name: <query2>})
```
- Allows to create a new field name called `new_field_name`, which has the value of the `query`

Useful operators for aggregation: `$concat`.



## Working with arrays

Check [the official documentation](https://docs.mongodb.com/manual/reference/operator/query-array/).

Arrays (lists) in MongoDB are treated as ordered lists, which means when querying the following, we will get only 
the documents with an exact match (ordered)

```
db.collection.find({list_name: ["value1", "value2"]})
```
- Will return only items with `["value1", "value2"]` (in this order)

To avoid caring about exact order and quantities
```
db.collection.find({list_name: {"$all": ["value1", "value2"]}})
```
- Return all items which contain `value1` and `value2` (not only those, and not in the right order)

### Find with arrays

We need to use the aggregation framework to find elements with an array of a certain size. We can do a trick though, which is check if a certain field (example: third one) exists in the arrray or not:

```
> db.find({ "field_name.2" : { $exists: true } } )
```

### Projecting arrays

Getting one element of a list in the results is not straight-forward. We need to use an `$arrayElementAt` operator:
```
> db.collections.find(<query>, {"second_list_element": {$arrayElementAt ["list_field": 1])
```

# Updating data

## Updating regular fields

Updating all fields that match a query.
```
> db.collection.updateMany(<query>, <update_query>)
```

Update queries use update operators:
- `$set`: set some fields to some values
- `$rename`: rename fields
- `$inc`: increment
-

## Updating array fields

### Changing array fields
```
> db.collection.updateMany( {} )
```

### Adding and removing more items to arrays

Adding a new field at the end:
```
> db.students.updateMany({ _id: 3 }, { $push: { grades : 200 } })
```

Removing a new fild (needs an empty query)
```
> db.students.updateMany({}, { $pop: { grades : -1 } } )
```

# Inserting fields

Same as `INSERT INTO`:
```
> db.collection.insertMany({field_name: value});
```

```
> db.dropDatabase();
```
- Erase the current database

Running MongoDB from a Docker image:

```
docker pull mongo
docker run --name my-mongo -d -p 27017:27017 mongo
```
