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

# 2 - Inheritance

## 2.1 Interfaces and abstract classes

### Interfaces

Interfaces in Java are conceptually equivalent to `ABC` (Abstract Base Classes) in python,
which define a class skeleton with empty methods. They are used to define a base interface,
and are useful in software development design.

Example:

```java
interface SoundBehavior {
  public void sound(); // abstract method - does not have a body
}

// "Quack" implements the "SoundBehavior" interface.
class Quack implements SoundBehavior {

  @Override
  public void sound() {
    System.out.println("Quack!");
  }
}

// "Animal" adds the functionality of performing the sound.
class Animal {
    SoundBehavior soundBehavior;

  public void performQuack() {
    soundBehavior.sound();
  }
}

// Implementation of "Quack" creates a type of animal.
class Duck extends Animal {

    public Duck() {
        soundBehavior = new Quack();
    }
}
```

> Note: the `@Override` operator informs the compiler the method is being overriden.

### Abstract classes

The `abstract` keyword is a non-access modifyer for classes and methods. They are used to
declare classes and methods that are intended to be extended. This means:
- `abstract` classes cannot be instantiated
- `abstract` methods do not contain a body

Additionally:
- `abstract` classes or methods cannot be declared `private`, `final` or `static`

