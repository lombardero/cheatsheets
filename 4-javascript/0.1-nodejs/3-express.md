# EXPRESS JS

`express.js` is a third party package that takes care of the details of handling requests and routing, to write cleaner `node.js` code.


## 1 Running Express.js
### 1.1 Initializing, importing Express
The command `npm install --save express` installs locally `express.js` (which is a third party package). Once it is downloaded, we can use it in our project.

```javascript
const express = require('express');
```
- The command above will import `express.js` into our file

### 1.2 Running an express server
```javascript
const app = express();

app.listen(3000);
```
- The code above launches an `express.js` server. Defining `app` and setting it up to `express()` creates a request listener (the variable `app` is now a valid `requestListener()` function that can be passed as an argument to `createServer()`). Using the `.listen()` to the `app` method then creates a server associated to the request listener defined above; the `listen()` method also allows us to set up the port where the app will be running.

In the background, `const app = express()` creates a `requestListener()` function for us (which can be passed as an argument to `node`'s `.createServer()`), and `app.listen()` calls `http.createServer()` for us, taking `app` as its request listener argument, and sets up the port number.

#### How Express handles requests
Note: instead of using a huge `requestListener()` function handling everything, what `express.js` does is 'split' the code into 'Middleware' functions (kind of like a 'funnel' where the request will come, and the server will spit our responses), which will perform different tasks. That allows us to split the code into different 'chunks' that are more manageable and readable.

### 1.3 Middleware functions
Once the `app` variable (our request listener) is created, we can start using express' middleware to handle requests; we do so with the `use()` function, which expects another function as an argument (this function will be done for each incoming request).

```javascript
app.use((req, res, next) => {
    computation;
    next();
});
```
- `.use()` will aplly the function defined inside of it to each incoming request. `.use()` expects a function with three arguments: `req` (the request), `res` (the response), and `next`, which is a function that tells express.js to look for the 'next' time we use `.use()` and 'continue'  the journey of the request there. (The only case we do not call `next()`, we should return a response).

These 'middleware' functions work as building blocks for our server, which behaves as a succession of them.

### 1.4 Sending responses
Once we have reached the 'end' of our server journey, we can send a response with the following statement:
```javascript
app.use((req, res, next) => {
    computation;
    res.send('<h1> Whatever title </h1>');
});
```
- The `send()` function is used to define the body of a request, as shown below.

Note: when `send()` is called, the Header will be set up to `text/html` by default (the header can be modified using `res.setHeader()` as well)

Check out in the source code how the response and the `send()` function are defined in `express.js`' source code [here](https://github.com/expressjs/express/blob/master/lib/response.js).

### 1.5 Handling routes
