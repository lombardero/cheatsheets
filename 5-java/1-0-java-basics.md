# Running code in Java

Java code can be run through `IntelliJ` (clicking the "play" button on the class/method)
or by running on the command line

```sh
$ java MyClassName
```

# 1 - Java conventions

## 1.1 Organising a Java repository

### Packages: group related Classes

A package in Java is the equivalent of a module in Python. It is a group of related
classes that are grouped using a package name (similarly to folders). Packages are
used to avoid naming conflicts, and writing better maintainable code.

## Classes: group functionalities

In Java, one file contains usually a single class. The name of the file will be the same
as the Java class (with a `.java` extension), which by convention is written
`InCamelCase`.

## 1.2 Building a class

### The `main` method

In Java, like many other languages, a "constructor" function can be defined while
building a class. This method will be run automatically when the file is run. In Java,
this function is called `main()` (works as Python's `__init__`).

Example of a `HelloWorld` class:
```Java
public class HelloWorld {
    public static void main(String[] args){
        System.out.println("Hello world!");
    }
}
```


