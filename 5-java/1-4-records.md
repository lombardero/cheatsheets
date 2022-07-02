# Records in Java

Records are immutable objects that were introducted to create quick types on-the-fly. They are immutable.

> Note: in python equivalent, `record` are immutable dataclasses

For example:

```java
// Define the record - instad of a tuple
record ProductCount(String productName, int items) {
}

// Use it now on the code instead of a Tuple
List <ProductCount> value = 
String pl = value.stream()
    .map(pc -> pc.items() + " of " + pc.productName())
    .collect(joining(", "));
```
