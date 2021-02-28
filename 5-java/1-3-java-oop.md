# Object-oriented programming in Java

An object in Java has two major characteristics: a state, and its behavior. A Class
is a blueprint for an object, which is composed by:
- The information it will be able to store (variables)
- The computation or behavior it will be able to have (methods)

# 1 - The basics

## 1.1 - Creating and instantiating a class

We can define a class in Java with the below syntax:
```java
public class Car {

    // In this part we define the variables these class will have
    public int doors;
    private String owner;
}
```
- This defines a new class `Car`, which will be accessible from other modules (for
  example, the `Main` class).

> Note 1: when a variables is `public`, it can be accessed from outside of a method (we
> can read adn write on it doing `car.variable`), a `private` one cannot be accessed
> (might be done so only through a method, for example)

> Note: In Java, one file contains usually a single class. The name of the file will be the same
> as the Java class (with a `.java` extension), which by convention is written `InCamelCase`.

Now, we can define an instance of the class (for example, in the `Main` file):
```java
public class Main {
    public static void main(String[] args) {
        Car my_class_instance = new Car();
    }
}
```

## 1.2 - Class methods

### 1.2.1 The `main()` method

In Java, like many other languages, a "constructor" function can be defined while
building a class. This method will be run automatically when the file is run. In Java,
this function is called `main()` (works as Python's `__init__`).

Example of a `HelloWorld` class with a `main()` method printing "Hello world":
```Java
public class HelloWorld {
    public static void main(String[] args){
        System.out.println("Hello world!");
    }
}
```

> Note: `main()` is the method that gets executed when the `new` keyword is called to
> instantiate a class.

### 1.2.2 Custom methods

The strength of classes is enabled through defining methods, which are functionalities
attached to that class.

We can define methods with the below syntax:
```java
public class MyClass {

    private int some_variable; // Will be accessible through the keyword "this"

    public void setVariable(int some_variable) {
        this.some_variable = some_variable;
    }
}
```
- Defining a class method that sets the internal value of `some_variable`

> Note: all instance variables (defined in the context of the class) are accessible
> through the `this` keyword.
