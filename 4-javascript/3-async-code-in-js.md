# 3 - ASYNCHRONOUS CODE IN JAVASCRIPT

## 3.1 Basics
### 3.1.1 Built-in functions
```Javascript
setTimeout(computation1, t_ms)

computation2
```
- Will perform the requested `computation1` after waiting `t_ms` miliseconds.

Note: Only the computation inside `setTimeout()` will wait `t_ms` to be executed: Javascript will run `computation2` wthout waiting for `computation1` to be finished (in this case, `computation2` will run before `computation1`).

### 3.1.2 Writing files
Files can be written synchonously (code gets blocked until file is created) or asynchonously (code continues to run during the file creation).

```Javascript
const fs = require('fs');

fs.writeFileSync('<file_name>.<extension>', content)
```
- Writes a file synchronously (code below this line goes not gets executed until the file is created). This can be problematic with big files.

```Javascript
const fs = require('fs');

fs.writeFile('<file_name>.<extension>', content, err => {
    code_run_after_file_created;
})
```
- The `writeFile()` function will

### 3.2 Callbacks and Promises
#### Callbacks
Callbacks are functions passed as arguments of other functions, and used in asynchronous code to state the 'dependent' functions.

```Javascript
const function1 = () => {
    computation1
}
const function2 = callback => {
    computation2(callback)
}

function2(function1)
```
- In the code above, `function1` is executed as a callback of `function2` (`function2` will be run only after `function1` has executed).

#### Promises
Promises are 'cleaner' ways to handle callbacks in Javascript. 

A Promise is a predefined object (`Promise()`), which takes a `resolve` and `reject` arguments. The `resolve()` statement is what the promise will return if the Promise works as expected (the condition should be defined by the user), and the `reject()` statement is what will be returned if the Promise does not work as expected.

The syntax of defining a Promise is shown below:
```Javascript
let new_promise = new Promise((resolve, reject) => {
    // computation
    if (condition_resolve){
        resolve('Message if resolved')
    } else {
        reject('Message if rejected')
    }
})
```

Once the Promise is defined, similarly to a function, it can be called using the `then()` and `catch()` statements to perform computations if the Promise is resolved or rejected.

The code below will run the promise:
```Javascript
new_promise.then((message) => {
    computation_if_resolved
}).catch((message)=> {
    computation_if_rejected
})
```


