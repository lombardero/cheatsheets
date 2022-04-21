# Introduction

MongoDB is a database storing collections of documents. A collection is defined as
a set of documents which -to make the querying optimal- should look similar. Documents
are JSON-like objects storing the data.

Some key features of MongoDB:
 - native support of Replication and Scalability; this is a feature which other
databases (such as the SQL-like ones) do not have, mainly due to being developed in the
2000s
 - rich query language, as powerful as SQL in terms of flexibility
 - built-in high availability: works as a distributed system out-of-the-box

## Advantages

The key feature of MongoDB is its flexible schema, this enables:
- No constraints for shape or datatype
- No object-relational impedance mismatch
- No complex joins (data is there as a blob already)
- Easier migrations (can change single documents)

## Quickstart

```sh
docker pull mongo
docker run -nname my-mongo -d -p 17017:2
```


# 1 - Documents

A document is a group of key-value pairs (JSON-like). It is the most unitary item that we can work with in Mongo.

```
{
    _id: ObjectId('61e234999532285f93"),
    name: "Peter"
}
```
- Note that all documents must have an `_id`, as it is what MongoDB uses as primary key. If not introduced, Mongo will add it automatically


## 1.1 Sub-documents

Documents can have nested fields. These fields can be any nested combination of:
- A nested key-value pair
- A list

That is called subdocuments. What makes it different
```mongodb
{
    _id: ObjectId('61e234999532285f93"),
    name: "Peter",
    address: {
        street: "whatever"
    }
    allergies: ["Peanut", "Lactose"],
    documents: [
        {type: "Passport", Number: "1234"},
        {type: "ID", Number: "14456"}
    ]
}
```

## 1.2 Document schemas

In MongoDB, each document can have different data schemas, which means for example that the fields of
a document in the same collection.

### How are these saved in the DB?

`MongoDB` stores documents in collections. Many collections form a database, and we can have many databases in a MongoDB instance.


# 2 - Replication & High availability

Mongo has built-in high-availability. It achieves this with `ReplicaSet`s, which are a group of instances working with a primary model and several secondary ones (slaves).

MongoDB also introduces the word Shard. A MongoDB usually works with several shards (which means -> several groups of instances working together), and that is a core part of the system. (Comes integrated)




