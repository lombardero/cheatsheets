# Data types, access modifiers


# 1 - Data types

## 1.1 Primitive data types

Primitive data types are "basic" data types in Java. They are not wrapped in an object,
rather, they are simple types of data that will be directly kept in memory. Java also
supports a wrapper class for each of these data types (i.e. `Integer` for `int`), with
additional features.

There are eight primitive data types in Java.

### Integer types

Java supports four types of signed integers, each using a different memory size:
- `byte`: 8-bit integer using a byte of memory (ranges from -128 to 127).
- `short`: 16-bit signed integer (ranging from -32768 to 32767).
- `int`: 32-bit signed integer (ranging from -2147483648 to 214748364 - if the max
  number gets added 1, it will "overflow" and become the minimum number). This is the
  default integer in Java.
- `long`: 64-bit signed integer. If we need integers out of the range of the `int`, we
  can use the `long` data type. To assign a value to this data type, we must add an `L`
  after the number. For example:

  ```java
  long myLongValue = 100L;
  ```

> Note: In Java, variables that are defined as integers will remain being so. For
> example, an odd integer that is divided by two will be equal to the integer part
> of the result.

### Floating point numbers

Java supports natively two types of floating point numbers:
- `double`: "double precision" number and the default floating point data type used
  by Java, it takes 64-bits of memory. Has a larger precision and range than `float`.
  Ranges from 4.9E-324 to 1.7976931348623157E+308. A `D` can be used to define a
  variable as a `double` (same as `long`).
- `float`: called "single precision", uses 32-bits of memory. Ranges from 1.4E-45
  to 3.4028235E+38. Has a smaller precision and range than `double`, and requires to be
  defined specifying a `F`. For example:

  ```java
  long myFloatValue = 100F;
  ```



- `boolean`
- `char`

## 1.2 Casting

Casting in java is converting a number from a type to another.

To convert an `int` into a `byte`, for example, we can do:

```java
int myInteger = 100;

byte myByte = (byte) (myInteger);
```

# 2 - Function keywords

When functions or class methods are defined, we need to specify two mandatory pieces of
information, and some optional ones:
1. The accessibility (`private` vs `public`)
2. The return type (Does the function return something? If so, what object or data type?)
3. (Optional) Is the function static? (Does it depend of the state of the outer class?)

The syntax to define a function in Java:
```java
//<access modifier> <return type> <function name> (<args>) {}
public void myFunction (str functionInput){
  // <some computation>
}

```

## 2.1 Access modifiers

`public` - `private`

## 2.2 Return type

`void` - Datatype


## 2.3 Static functions
