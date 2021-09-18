# C# very basics

# 1 - Code entrypoint

The C# code starts executing through the `Main()` method defined by any of the classes
of the file. To work properly, the `Main()` method must:
- Be the only one in the file (there cannot be two classes defining a `Main()` method)
- Be defined as `static`

# 2 - Variable types

```cs
string stringVar = "Hello World!!";
int intVar = 100;
float floatVar = 10.2f;
char charVar = 'A';
bool boolVar = true;
```

# 3 - Object defitions

## Access modifiers

Access modifiers enable or disable the access to certain variables or methods by other
parts of the code:
- `public` means anyone can access it
- `private` means it cannot be accessed

## Static callables and classes

### For classes

In C#, `static` means that it cannot be instantiated. A class that is defined as `static`
will not have any instances (nor instance variables).

### For methods

Static methods are shared across all instances of a class. The method does not require
accessing information about the instance to execute.

## Return type

In C#, functions and methods require annotations of their return type:
- `void`: means the callable returns nothing
- `<data type>: the callable returns the specified data type

# 4 - Basic actions

## Logging

The basic print statement in C# works very similar to Python:

```cs
print("Hello World!");
```

