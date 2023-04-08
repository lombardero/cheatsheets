# Functions in JavaScript

Functions are objects that perform a series of isolated computations whenever they are called. They can take (or not) variables as inputs, which will then be used inside of the function to compute a result.

Notes on functions:

- functions are 'isolated' statements, meaning that once run, they will make a copy of their input variables, perform the computations stated, and return something if asked. The variables will be then erased from memory
- functions can only access their input variables. The variable names used as inputs will be valid only within the function
- global variables (defined with `const`) are an exception of the above statement; they can be accessed by functions without needing to be inserted as arguments.
- functions defined inside another function can access any variable defined in the first function.

# 1 - Standard Syntax

The standard syntax uses the `function` keyboard followed by the name of the function to define it.

Example1:

```Javascript
function newFunction() {
    var function_variable = 1; // this will belong only to the function
    computation
}
```

Example 2:

```Javascript
function newFunction(input_variable) {
    computation;
    return computation_result; // this will be returned by the function
}
```

# 2 - Arrow functions

Arrow functions are a symplified way of defining functions. Instead of using the `function` keyword, we create a constant with the name of the function, and set it equal to an anonymous function (function with no name). The function is defined using the statement `=>` (or 'arrow') as shown below.

First syntax for Arrow functions:

```Javascript
const newFunction = (input_variables) => {
    computation;
    return computation_result;
}
```

Arrow function syntax allows to symplify functions that use the `return` statement as well. Instead of using the syntax above, we can use the symplified version below:

```Javascript
const newFunction = (input_variables) => computation_result;
```

Note: in the case there is only one input variable, the parenthesis can be removed.
