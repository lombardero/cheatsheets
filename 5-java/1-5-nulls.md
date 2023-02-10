# Nulls in java

In Java, the `NullReferenceException` is a classic hurdle, happens when an object that

To sort that out, we:

1. Check with business if a value could (in theory) be null
2. Define it as `Optional`
3. When using that Optional value to get another, account for the case it is null by getting it through a Map and return something if it is null

See a syntax example below with an address that could be null:

```java
dto.contactPerson = parcel.getDelivery().flatMap(de -> de.getAddress().getContactPerson()).orElse(Null);
```
