# Java basic syntax

# 1 - Defining variables

Variables can be first initialized (a type is set), then set to some value, or both
things at the same time.

## 1.1 Initialising a variable

To initalise a variable in Java, we need two things: a type and a name for it.

```java
ObjectName variableName;
```

- The variable `variableName` of the type `ObjectName` is now initialised and can be
  accessed by future statements.

## 1.2 Defining a variable

Optionally, we can set the variable to some initial value, for example:

```java
int variableName = 0;
```

- Sets `variableName` to zero

> Note: from Java 10 onwards, we can use `var` to dynamically define the variable type
> if we set it up to something.

## 1.3 Complex variables

Some more complex objects such as classes or arrays require a more complex syntax to
be initialised. They require the `new` keyword, which will call the constructor function
to initialise the object.

For example, to define an `ArrayList` we will need to use:

```java
ArrayList<Object> variableName = new ArrayList<Object>();
```

# 2 - Logic statements

## 2.0 Boolean conditions

The basic boolean conditions supported by Java:

- `!<boolean>`: returns the opposite (`!` equals "not")
- `<boolean> && <boolean>`: returns the logical "AND" of both boolean
- `<boolean> || <boolean>`: returns the logical "OR" of both boolean

## 2.1 `if` statements

A basic `if` statement in java looks like this:

```java
if (<boolean condition>) {
    // Some computation
}
```

For simple `if` statements, we can avoid using a `{}` context manager. For example, the
below syntax is perfectly fine:

```java
if (<boolean condition>) return false;
```

We can add `else if` and `else` statements:

```java
if (<boolean condition 1>) {
    // Some computation
} else if (<boolean condition 2>) {
    // Some other computation
} else {
    // Yet another computation
}
```

# 3 - Loops

## 3.1 `for` loops

For loops can be built either by iterating through a range or a list.

### Iterate through a range

`for` loops in Java that iterate through a range use the below syntax:

```java
for (int i = startValue; i < endValue; i++) {
    // Some computation.
}
```

- The loop will iterate for `i` from `startValue` to `endValue` (not included),
  considering steps of `1` (`i++`)

### Iterate through an array

```java
for (element : elementArray) {
    // Some computation of element
}
```
