# 2 - OBJECTS AND CLASSES IN JAVASCRIPT

## 2.1 Objects in Javascript
### 2.1.1 Predefined objects
#### Arrays
Arrays are lists of primitive variables or other objects.
```Javascript
const new_array = ['hello', 123, [1,2,3]]
```
Note: reference value types such as arrays can be modified even if they are declared through a `const` statement. This is due to the fact that what is 'constant', is the pointer to a location on the Heap where the data is stored. The pointer will never change, but what is stored in the Heap can be.

##### Array methods
- `<array>.map(function);` iterates through `<array>`, and creates a new array (the original `<array>` remains unchanged), applying the `function` inserted element-wise (if no function is inserted: `<array>.map()`)
- `<array>.slice(idx_start, idx_end);` creates a copy of `<array>`, from index `start_idx` to `end_idx`

##### The 'spread' `...` operator
The spread operator allows us to 'take out' the data content within an object (array or object) to add it as data for another object without creating an object within an object.

```Javascript
const numbers = ['one', 'two', 'three']

const copiedNumbers = [...numbers, 'four', 'five'] // copiedNumbers will have all numbers until five
```
- in the code above, the operator `...` will iterate through the `numbers` array, and add each element to `copiedNumbers` separately, creating a new array with the same contents as `numbers` plus the ones added.

##### Iterating through an array
```Javascript
const numbers = ['one', 'two', 'three']

for (let number of numbers) {
    console.log(number);
}
```

Note: the `...` operator, when used in the arguments section of a function (now called the rest operator), can be used to create an array with all inserted arguments to that function, as shown below.
```Javascript
const function = (...args) => {
    return args;
} // will will return all inserted arguments in an array: ex: function(1,2,3) will return [1,2,3]
```
##### Array de-structuring
We can copy over the contents of an array using the below syntax:
```Javascript
const array = [1, 2, 3]

const [one, two, three] = [1, 2, 3]
```
- The code above will create three variables (`one`, `two`, and `three`) set up to the three values of the array.

### 2.1.2 Defining objects
Objects allow us to 'group data together' in an enclosed element that holds structured data. The data it holds can be primitive variables, other objects or even functions.

An object can be defined as follows:
```Javascript
const new_object = {
    property1: 'Hello', // property1 can be called using new_object.property1
    property2: 123, // property2 can be called using new_object.property2
    function() {
        console.log(this.property1 + ', I can be called using \'new_object.function()\'!')
    }
};
```
Note: to see what the `this` statement does, go to point `2.3`. In order for 

#### Object de-structuring
Object de-structuring (`{...}`) is used to explicitely define only some properties of an object that a function needs to be executed.

Considering the following object:
```Javascript
const new_object = {
    property1: 'Hello',
    property2: 123, 
    }
};
```

We can create two new variables called `property1` and `property2` (separated from the object) with the below syntax:
```Javascript
const { property1, property2 } = new_object
```
- Te code above creates two new variables from the object properties.


We can use the below syntax (explicitely requesting some properties) to explicitely request a part of the object:
```Javascript
const function = ({property1}) => {
    console.log(property1);
}
```
- The above function expects the full object as an argument (`function(new_object)`), but instead of adding the whole object as a variable when the function is run, only the properties selected are copied over.

## 2.2 Defining classes


## 2.3 The `this` statement
`this` stands for 'whatever called the function', and is a variable that has two uses. 

More info: 
https://academind.com/learn/javascript/this-keyword-function-references/
https://www.youtube.com/watch?time_continue=1&v=Pv9flm-80vM&feature=emb_logo

### 2.3.1 First use: binding variables to a class
When defining a variable in the constructor of a Class, it will tell it to 'bind it' to the class, that way, that variable will be accessible at any point in the class (for example, as an argument for any of the methods of the class). On top of that, that variable will be accessible when an instace of the class is created.

### 2.3.2 Second use: to access a variable within the class
When a command is run inside of a function or a class and a variable name (or pointer) is added to its arguments, it will first look at the variables inside of the constructor of the class (not its methods), and then, the variables defined globally. If a constructor must access a method of the class, for example, we must use the `this` statement to explicitly ask that the method we are using is defined in 'this' current class.

For example, if a Class method needs a class variable to execute itself, we can use `this` to refer to the Class variable we require. 

Note: if we use an arrow function, (`=>` keyword), `this` will refer to the 'global' environment of the program, not the class itself. To avoid that, we must define the function using the alternative syntax shown below:
```Javascript
const object = {
    property1: 1, // property1 can be called using new_object.property1
    method1() {
        console.log(this.property1 + 1)
    }
};
```

### 2.3.3 Binding `this`
In occasions, we must use the `bind(this)` method to a function to pass in the same `this` statement. 

For example, in the case below:
```Javascript
class NewClass {
    constructor() {
        this.class_variable
        outsideFunction(this.classFunction.bind(this))
    }

    classFunction() {
        this.class_variable
        computation
    }
}
```

In the above function, we use `bind(this)` to tell the `this` of the method `classFunction` to be the same as the `this` of the `NewClass`. Otherwise, since `this` means 'whatever called the code', it would think that `this` is the `outsideFunction` (since that is what called it). Without `bind(this)`, the `classFunction()` would not be able to access `this.class_variable` (it would look for a `class_variable` inside of `outsideFunction`, where it does not exist)