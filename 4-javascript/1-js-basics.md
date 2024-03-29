# JAVASCRIPT BASICS

1. [The Javascript Very Basics](#1-the-javascript-very-basics)
2. [Conditional statements](#2-conditional-statements-in-javascript)

This document is a quick introduction the Javascript very basics, such as defining variables, computing simple operations, and simple syntax such as defining functions and logic statements.

# 1 The Javascript Very Basics

## 1.1 Variables

Javascript has two groups of variable types, primitive values and reference values.

### Primitive value types

Primitive value types consist of variables consisting of a single value (as opposed as objects, which can be large chunks of data). Because they are small, they are directly stored on the Stack. That means each time a variable is defined, the Stack will create a new instance and copy the variable over in another location of the stack.

The primitive data types are:

- `number`: all numeric variables `integer`, `float`
- `string`: any succession of characters, defined between single or double quotes: `'this is a string'``
- `boolean`: a binary classification: either `True`, or `1`, or `False`, or `0`
- `null`: an empty variable
- `undefined`: a Javascript data type that flags that the variable does not have a defined value
- `symbol`: a Javascript data type that creates a unique value every time the function `Symbol()` is called (used as an identifier).

### Reference value types

Reference value types are used for larger and more complex 'chunks' of data such as objects (they can contain any type of data such as a series of primitive types such as an array of numbers, or even reference types such as an array of arrays). Because of their size, they cannot be stored on the Stack directly, instead, the Stack will save a pointer to a location in the Heap, where the actual data inside the object will be stored.

The reference value types are:

- `object`: any type of data 'building block' of data holding values (can be primitive or referenced). Example: `array` and `dictionnaries`.

Note: this value type can cause confusions. Since what is stored is a pointer to the Heap location where the data is stored, once we define an array (for example, `array = [1,2,3]`) and we make a copy of that array (for example, `array2 = array`), what is copied over is the pointer to the same location on the Heap where the data is stored. That way, following our example, if we set `array = [1,1,1]`, the value of `array2` will also be updated to `[1,1,1]`, since both arrays will point to the same.

#### Arrays

Arrays are lists of any type of variable (such as lists of numbers, strings, arrays, or a combination of all)

Example of an array:

```Javascript
var arr = ['im a string' ,1234, ['list','of','things']]
```

#### Dictionnaries

Dictionnaries are an optimized format (hash table) to retrieve data using a key, which can be anything we define.

```Javascript
var obj = {
                    'key1': 'hello',
                    34: 42,
                    'key3': ['im', 'an', 'array']
                }
```

## 1.2 Basic syntax

### Comments

- `//`: single line Comment
- `/*` multi line Comment (needs to be closed with the mirror operator `*/`)

### Numeric operators

- `+`, `-`, `*`: sum, substraction, multiplication
- `=`: assign value
- `+=`, `-=`, `*=`, `/=`: adds, substracts, multiplies, or divides the operator by a value and re-assigns it
- `<var>++, <var>--`: adds one or substracts one to the variable

### Boolean operators

- `a == b`: returns `True` if `a = b` without being strict on the value type (for example, the statement `3 == '3'` will return `True`)
- `a === b`: returns `True` if `a = b` when `a` and `b` have the same value type (this time, the statement `3 ==='3'` will return `False`)
- `a != b`: returns `True` if `a` is different from `b`, not being strict on value types (the opposite of the operator `==`)
- `a !== b`: returns `True` if `a` is different from `b`, or both are different value types (the opposite of the operator `===`)
- `<`, `>`, `<=`, `>=`: compares numbers in a loose way (does not care of type)
- `a && b`: computes a AND b
- `a || b`: computes a OR by

### Defining variables

Defining a variable in Javascript will allocate a slot in the Stack to store the value of the variable directly (if variable is primitive) or a pointer to a Heap location (if variable is of reference type). We do so through the `var` statement, as shown below

> Note: from JavaScript 6 onwards, the `let` - `const` syntax is preferred, to let the user define how that variable should be used explicitly (local vs constant)

The basic syntax to define a variable in Javascript is:

```Javascript
var variable_name = 'variable_value';
```

### Local variables

`let` will work very similarly as `var`, but will define a variable locally, in the scope of a block (`{...}`) instead of globally. Use `let` for variables that will change.

Syntax:

```Javascript
let local_variable_name = 'i_am_a_local_variable';
```

### Defining constants

Global constants will be accessible in the whole code (even inside functions), and are used to be explicit about what we plan to do with variables defined. `const` should be used for any variable that will not change throughout our script: if we try to change the value initially set to a constant, we will get an error. Note that the convention states that global constant names are in caps, and use underscores as separations.

The basic syntax to define a Global variable in Javascript is:

```Javascript
const GLOBAL_CONSTANT = 'variable_value';
```

> Note: trying to re-assign a `const` variable will throw a `TypeError`

### Importing modules

Javacript uses the `require()` keyword to import modules or libraries. We can import JS pre-built modules or files we have created.

The syntax is as follows:

```Javascript
const module_name = require('prebuilt_module_name');
```

- In the code above, we import `prebuilt_module_name`, and name it `module_name` on the current script. That will allow us to access its functionalities using the name we have given it. (Not specifying a path will look for any prebuilt library)

To import a file from our folder:

```Javascript
const module_name = require('./imported_module.js');
```

- The code above will import `imported_module.js` from the current folder (`./` indicates relative path, `/` would work for absolute path). Note that the import would still work without stating `.js` (Javascript looks for `.js` files only)

## 1.3 Basic operations

### Querying data type

```Javascript
typeof variable_name;
```

- returns a string with the variable type of `variable_name`

### Requesting an input

```Javascript
new_variable = prompt("Tell me the new variable");
```

- when run, will request a user input, and set the value to `new_variable`(same as `input()` in Python)

### Printing results

```Javascript
console.log(variable);
```

- prints the contents of `variable` in the console (same as `print()` in Python)

```Javascript
alert(message);
```

- will pop out an alert box to warn the user of the `message` that was introduced

### Numeric operations

```Javascript
number.toFixed(n);
```

- prints the numeric variable `number` as a string with `n` numbers after the comma

```Javascript
String(34);
```

- returns the numeric value as a sting

### String operations

```Javascript
string.length;
```

- returns the string length (number of characters)

```Javascript
string.toUpperCase();
```

- returns a copy of the string in upper case (does not modify the value of the variable `string`)

```Javascript
Number('34');
```

- returns the numeric string as a number data type

```Javascript
const text1 = 'Paul';
const text2 = 'McCartney';
console.log(text1 + text2);
```

- Will return the complete string.

```Javascript
const text1 = 'Jude';
const text2 = 'make';
console.log(`Hey ${text1}, don't ${text2} it bad`);
```

- Will log in the console the complete text. Note that for the above text to work the `\`\`` (open accent) characters need to be used.

```Javascript
const text = 'Hello-darkness';
text.split('-');
```

- `split()` will return an array of strings, 'splitting' it from all points where the character in the argument appears. (In the above example, the console will return `['Hello','darkness'])`.

### Array operations

```Javascript
array[n_idx];
```

- returns the variable stored in the `n_idx` index in the array

```Javascript
array.length;
```

- returns the length (number of elements) of the array

```Javascript
array.push(new_element);
```

- Adds a `new_element` at the end of the string (same as Python `append()`)

### Dictionnary operations

```Javascript
obj['key1'];
// or alternatively: 'key1'.obj;
```

- retrieves the data stored in `'key1'` of the dictionnary `obj`.

# 2 Conditional statements in Javascript

To define conditional statements in Javascript, we us what in Javascript is defined a 'block', which delimits the code affected by a statement. Blocks are used to delimit the code of functions as well. Blocks are delimited by brackets: `{...}`.

## 2.1 `if` statements

### Basic `if` statements

If statements are defined with a boolean condition, and perform a series of computations if that statement is true.

```Javascript
if (<Bool> condition) {
    // <computation if Bool == True;
}
```

### Multiple conditions

In case there are multiple conditions, the statements `else if` and `else` can be used to check for further conditions if the boolean of preceding statements is not True.

```Javascript
if (<Bool> condition1) {
    computation1 // if condition1 == True;
} else if (<Bool> condition 2) {
    computation2 // if condition2 == True;
} else {
    computation3 // if previous conditions are not True;
}
```

### Switching between values of a variable

In case the different computations depend on the value of a variable, we can use the `switch()` statement, as follows:

```Javascript
switch(a){
    case k:     //if a == k
    computation_if_k
    break;
    case n:    //if a == n
    computation_if_n
    break;
    }
```

## 2.2 `while` statements

While statements have two syntaxes in Javascript, depending on how we want our code to behave.

If we want to first verify a condition, and then do a computation, we must use the `while` statement at the beginning as shown below:

```Javascript
while (<Bool> condition) {
    computation; // computation done as long as condition == True
    }
```

Note that a `break` statement can be used inside the `while` loop to stop it.

If we want to perform a computation, then do a verification to see if the loop mus continue, we must use the `do` statement first, followed by a `while` statement, as shown below:

```Javascript
do {
    computation; // computation is done always; another iteration will be done if condition == True
} while (<Bool> condition)
```

## 2.3 `for` loops

`for` loops require three arguments to run: the start of the iteration, a boolean condition ('do another iteration until the condition is `False`), and the step definition. An example is shown below:

```Javascript
for (var i=0; i<=9; i +=1) {
    computation; // computation is done for every i until the loop ends
}
```

Alternative syntax (iterating through a list)

```js
for (const item in items) {
  // do something
}
```
