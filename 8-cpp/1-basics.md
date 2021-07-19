# C++ basics

## 1 - Basics

### Basic statements

`cout`: stands for "console-out". Basically a "print" statement.
`endl`: stands for "end line", allows to finish the print statement

### Defining variables

To define a variable in C++ we must us the below syntax:
```c++
<data-type> <variableName>;
```

### Basic operators

#### Insertion

`<<`: insertion operator. This operator takes the representation of the variable added
to its right, and outputs it into the output stream. Formatting settings can be applied

Example:
```c++
str Name = "Manuel";
cout << "Hello, my name is " << Name << endl;
```

### Data types

- `char`: One single character. Ex: `char chatacter = 'A';`
- `string`: A string of characters
- `int`: Integer.
- `float`:
- `double`: More precise than `float`
- `bool`: Boolean

## 2 - Organisation

### The `main()` function

Like in many other programming languages, in C++, the `main()` function is th script
entrypoint: the place where code is going to start running.
