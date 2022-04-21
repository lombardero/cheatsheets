# MongoDB Data patterns

# 0 - Data model guidelines

Things to think when creating a MongoDB data model:

- How the data will be used
- How the data will be queried (this one is critical)
- Critical queries (data model should them optimal)
- Ratio between reads and writes
- Separate frequently used data from historical data

> Mongo has a 16MB limit for documents

# 1 - Data relations in MongoDB

## One-to-one relationship

For one-to-one relationships we can either embed, or link.

Basically, it means, we can add the whole field as part of the document, or link it (same as in SQL).

### Embedding the data
```
{
    _id: 1
    name: Paul
    address:
    {
        street: "Abbey Road",
        number: 123
    }
}
```

### Linking the data
```
{
    _id: 1
    name: Paul
    address_id: 1
}

{
    _id: 1,
    street: "Abbey Road",
    number: 123
}
```
The advantage of Linking is that we can ensure the relationship is one-to-one

> Note: the above documents should be in different collections, and they can be joined
> using the aggregation framework

## One-to-many relationship

For this relationship, we can have the data embedded on the "one" side as a list, or on the "many" side (lots of duplication, less used, but might also be interesting depending on how we plan to query the data)

## Many-to-many relationship

For a many-to-many, the most frequent way to do it is to link the data on both sides as a list of foreign keys.

# 2 - Patterns

Data patterns used in MongoDB databases.

> See [this post](https://www.mongodb.com/blog/post/building-with-patterns-a-summary) for more info.

## Polimorphic pattern

Main idea: use collections of documents that are similar but not exactly the same.

This pattern is the most common, and one of the main advantages of Mongo DB. It is used for data that is very similar, but not completely identical.

For example: products in a supermarket. Some have specific fields that are unique for them. For example, fresh products might have freshness info, bottled objects might have volume, some others weight, or number of rolls - toilet paper - etc.

## Extended reference pattern

The idea of this pattern is to embed data we frequently use in one collection.

For example: we can have an Orders collections, with every order done for every customer. If we frequently use the address of the customer for the order, we might want to add that address into the Orders Collection direclty. This is also valuable in this case because the Customer might change the address later, and the orders would keep the address back at that time.

## Subset pattern

RAM is a key resource in databases: if data does not fit in the RAM, the DB needs to read it constantly from disk.

In some cases, the data is too large to be kept completely in one document. Example: reviews for a given product. With the subset pattern, we can keep part of the reviews in the Product, and the complete data (list of all reviews) in another document.

## Computed Pattern

To avoid expensive queries, we can do some pre-computation of data and add it in the database.

This can be achieved:
- At every insert
- Using a cronjob

## Attribute pattern

The idea here is to create new attributes to make querying easier (?)
