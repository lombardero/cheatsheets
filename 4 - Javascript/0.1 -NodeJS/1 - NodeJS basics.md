# 1 - NODEJS BASICS
This document is an introduction to some of the NodeJS basics.

## 1.0 Basic file organization
### Basic files
NodeJs projects should be organized as follows:
- `app.js` file: the 'core' file of our server, the one holding the server functionalities and dependencies. This is where we call the `createServer()` function
- `routes.js` file: this file contains all the routes of the server, which are specified in the `requestListener()` function that will be passed as an argument to `createServer()`.

### Exporting files in NodeJS
Any object (class, function, variable) can be exported in NodeJS using the `module.exports` statement. This will make available globally whichever of the objects we set it equal to in any other file, by calling the `require('filename')` statement.

Example: creating `requestListener()` function in the `routes.js` file:
```Javascript
requestListener = (res, req) => {
    computation;
}

module.exports = requestListener
```
- This will make the `requestListener()` function available in any file.


Then, in the `app.js` file we import it as follows:
```Javascript
const routes = require('./routes');

const app = createServer(routes);
```
- The first line imports the object stored in `module.exports` from the `./routes.js` file (note that the `js` extension is deduced by JS), and sets it equal locally to the variable `routes` (now, `routes` equals the function `requestListener`). The second line executes `routes()` inside of `createServer()` (see point 1.2).

Note: to export many files, we can set `module.exports` equal to a dictionnary with many keys; each key will allow us to retrieve each property on the next file.

On the imported file we can use both syntaxes:
```Javascript
// Syntax 1:
module.exports = {
    listener: requestListener,
    data: 'whatever',
};

// Syntax 2:
module.exports.listener = requestListener;
module.exports.data = 'whatever';
```
- Creates an object with multiple data to be imported. 
Note: `module.exports` can be replaced by the shortcut `exports` (NodeJS will understand it).

On the main file:
```Javascript
const imported_file = require('./imported_file');

const app = createServer(imported_file.listener);
```
- Accesses the `listener` property of the `imported_file` (which in this case is the `requestListener()` function)

## 1.1 The `fs` library
`fs` stands for Filesystem, and enables file creation and modification by NodeJS.
```Javascript
const fs = require('fs');
```

### Writing in files
```Javascript
fs.writeFileSync('<filename>.<extension>', 'file content');
```
- Creates a `'<filename>.<extension>'` file with the specified content on the program working folder.

## 1.2 The `HTTP` library
The `http` library allows us to launch the server and handle requests. It is imported using the syntax below:
```Javascript
const http = require('http');
```

### 1.1.1 Launching the server
#### Creating the Server
To launch the server, we need to use the `createServer()` functionality of the `http` module.
```Javascript
const server = http.createServer(rqListener);
```
- `createServer()` starts the Server, which will listen to requests until stopped. It takes in a `requestListener()` function as an argument, which will be executed for every request the server receives (note that we need to pass the function pointer without executing it). `createServer()` returns a `Server` object, which will be stored in the `server` variable we created (once this method is run, we will have a running instance of our server).

Note 0.1: The 'event loop' is how NodeJS handles requests. It is a single Javascript thread (a single process) that keeps on listening iteratively to incoming requests and doing the work associated with each request if possible, instantaneously, otherwise (if it has no time), it writes the work to be done in a registry, and will do it on the next iterations of the event listener. To stop the process, we can use the `process.exit();` command. To quite the NodeJS app, we can simply run `CTRL + C` on the terminal.

Note 0.2: NodeJS uses multi-threading to handle time-consuming OS-level processes (such as reading or writing files), in the 'Worker pool'. This allows NodeJS to not stop the event listener while creating or reading files (which would slow down critically the server).

Note 1: `requestListener()` will have to be defined by us.

Note 2: `requestListener()` is a void function (does not return anything) that takes an `IncomingMessage` object (the client request) and a `ServerResponse` object (the server response) as arguments. We define the request listener function:
```Javascript
function rqListener(req, res) {

}
```

Alternatively, we can create an anonymous function (arrow function) directly inside of `createServer()`:
```Javascript
const server = http.createServer((req, res) => {
    computation;
});
```
- The code above will start a server listening to `req` requests, and sending `res` responses. Note that the function defining the `computation` will be executed asynchonously, only when the user sends a request to the server.

#### Listening to the server
Once the `server` variable (containing a `Server` object) is created, we can call methods on it. One of them is the `listen()` method.

`listen()` will create a running instance that will keep on 'listening' to incoming requests. `listen()` takes two optional arguments: the port number (can be specified, is 80 by default), and a host name (localhost by default).
```Javascript
server.listen(port, host_name);
```

### 1.1.2 Getting Requests
### Listening to Requests
Requests given by browsers are usually complex JSON objects, with a lot of information and meta-data (such as which browser the request came from, what response format is expected, cookies, and many more). We can access requests using the `req` argument defined in the `requestListener()` function of the `createServer()` method.

In NodeJS, we can filter relevant parts of the response by calling  pre-built methods on it. Assuming `req` is the client request:
- `req.url` will return the URL from which the request came from (everything after the home name). For example: will return `/` if nothing is added.
- `req.method` will return which HTTP method was used in the request (`GET`, `PUT`, `POST`, `DELETE`, etc.).
- `req.headers` will return the request header (which has most of the valuable meta-data such as the request and client information, and the response expected).

### Event listeners: Getting the user has posted
In NodeJS, to receive data the user has posted (`POST` method), we need to create a specific event listener (note that `createServer()` creates an event listener implicitely to get the user requests).

```Javascript
req.on(listened_data_type, (incomming_message) => {action})
```
- The `.on()` method listens to the `listened_data_type` (which is a string that specifies the type of data listened for, such as `'data'` or `'end'`), and performs a the `action` specified with the `incomming_message` that we specified in the arrow function inserted as second argument.

Important note: The callback function passed in as a second argument of the `on()` method will be only triggered when data of the selected type is listened (execution will be asynchonous).

Example1: listening to data and parsing the message
```Javascript
const body = [];
req.on('data', (data_chunk) => {
    body.push(data_chunk);
})
req.on('end', (data_chunk) => {
    const parsedBody = Buffer.concat(body).toString();
})
```
- In the code above, the first event listener checks for `'data'` transmitted, and adds it to an array of data called `body`. A second event listener checks for `end` of transmission, and concatenates the chunks of data received in a `Buffer` object, to be converted to a string (assuming the input is a string).
Note: the `Buffer` object is a NodeJS class allowing to read streams of binary data; in the above case it allows to 'translate' from binary data the incomming string.

#### Setting up responses depending on event listeners
Important note: In NodeJS, the event listeners are kept active constantly: they will keep on listening to data even if a response has already been sent. That is why, if the response depends on that event listener, all the modifications to `res` should be inserted inside the `req.on()` statement (inside the function of the second argument of `on()`).

### 1.1.3 Sending Responses
The `requestListener()` function allows us to set up server responses thanks to the second argument of the function, `res`. NodeJS allows to set up the response by modifying the `res` object, which is empty by default.

#### Response header
```Javascript
res.setHeader(key, value);
```
- Sets up a `key`-`value` pair on the Response header. Example of valid `key`-`value` pair: `'Content-Type'`- `'text/html'` (this tells the browser that the response sent is HTML)

```Javascript
res.setHeader('Location', url);
```
- Sets the Header to the `url` specified (sends the client to that URL)

#### Response body
The body of the response can be set up line by line using the `write()` method, as shown below:
```Javascript
res.write('<html>');
res.write('<head><title> Title </title></head>');
res.write('<body> Body contents </body>');
res.write('<html>');
res.end();
```
- The code above writes up a five-line HTML response that the server will return. 
Note: when we are finished writing the response, we must explicitely notify NodeJS using the `end()` method (we will get back an `Error` if we try to `write()` again in the response).

Note: setting a `return res.end()` will explicitely end the modification of the server response, even if additional lines of code (`res.write()` statements) are stated on the code.

More about responses: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers

#### Response status code
We can set the status code of the response as with the `statusCode` statement, as shown below:
```Javascript
res.statusCode = 404;
```

## 1.1.4 Routing responses
Routing responses (selecting different server responses depending on the URL) can be done with `if` statements.

```Javascript
const server = http.createServer((req, res) => {
    const url = req.url;
    if (url === '/') {
        res.write('blabla');
        return res.end();
    }
    if (url === '/url2') {
        response_if_url2
    }
});
```
- In the code above, we first request the `url` the client has gone into, and select a response depending on it.
Note: we `return res.end()` to explicitely end the response editing.