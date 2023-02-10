# Functional interface in Java

The functional interface was introduced in Java 8, and adds a set of functional
programming interfaces enabling key features.

> Note: even if they are called "interfaces", these objects are not Abstract
> Base Classes. They add some required features.

# 1 - Consumer

The `Consumer`, as the name indicates, is an interface that "consumes" an
input (does not have an output), and does something with it; this "something" is what needs
to be defined by the programmer thogh a lambda function. The interface also
enables to compose consumers.

## 1.1 The `accept` method

The accept method accepts an input and simply executes the lambda defined by the programmer.

Example: let's define a consumer named `print` that prints a string to the console.

```java
// Defining the consumer.
Consumer<String> printToConsole = myString -> System.out.println(myString);

// Using the consumer.
printToConsole.accept("gump!")
```

- Defines a `printToConsole` consumer that will print to the console any string it receives.

## 1.2 Combining consumers

Consumer functionalities can be combined together easily through the `andThen` built-in
method.

Example: let's see how we can combine the above-defined `printToConsole` consumer
with one that converts any uppercase string to lower.

```java
// Defining a new consumer.
Consumer<String> toLower = myString -> myString.toLowerCase();

// Using both consumers.
toLower.andThen(printToConsole).accept("BUBBA!")
```

# 1 - Supplier

The `Supplier`, as the name indicates, does not take any input but supplies an output,
which is computed through a lambda function taking no arguments which the programmer
defines when the supplier is created. Then, that lambda is called each time the `get`
method is called.

## 2.1 Getting data from the supplier

The `get` method is the only method suppliers require. It will trigger the lambda function
defined in the supplier, and output the value from that lambda. Let's visualize it through
and example.

Example: let's define a supplier of random values:

```java
// Defining the supplier.
Supplier<Double> randomValueSupplier = () -> Math.random();

// Getting a new random value from the supplier.
Double randomValue = randomValueSupplier.get()
```

- The Supplier defines the logic, and now the Supplier API enables to use the logic
  without modifying the code using it.
