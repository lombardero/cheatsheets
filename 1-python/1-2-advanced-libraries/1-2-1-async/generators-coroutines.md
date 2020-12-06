# Generators and Coroutines

# 1 - The foundation of Generators: iterables

Iterables in python are objects that support `__iter__()`. To work properly, this method
should return an object that remembers a state and has a `__next__()` method defined;
this method should return some data.

Let's illustrate this by re-implementing the `range()` generator as a class:

```python
class MyRange:
    def __init__(self, start, end):
        self.start = start
        self.end = end
    
    def __iter__(self):
        return RangeIterable(self.start, self.end)

class RangeIterable:
    def __init__(self, start, end):
        self.start = start - 1
        self.end = end - 1
    
    def __next__(self):
        if self.start >= self.end:
            raise StopIteration
        self.start += 1
        return self.start
```
- Now, we can use `for numbr in MyRange(1,10)` the same way we would do with
  `range(1,10)`

To make a more formal definition, we can define iterables as:
- All objects supporting the dunder method `__iter__()`, which should return a
  **generator** instance.

And a definiton of a Python **generators** is:
- All objects that support the `__next__()` dunder method, which returns some value.

## 1.1 Under the hood of `for` loops

For loops need these `__iter__()` and `__next__()` methods to work.

First, by grabbing the iterator object through `iter()` (which runs `__iter__()`), then
by calling `next()` (which runs `__next__()`) successively through a while loop until
`Stopiteration` is raised.

Let's visualise this by running the implementation of `for element in MyRange(1, 10)`:

```python
# Implementation of a for loop:

iterable = iter(MyRange(1, 10)) # returns RangeIterable(1, 10)

while True:
    try:
        next(iterable) # Runs `iterable.__next__()`
    except StopIteration:
        break
```

## 1.2 Generators: iterables with enhanced syntax

Generator functions are exactly like the `RangeIterable` function: a function that
remembers a state and returns some data through its `__next__()` method. We can
define `RangeIterable` as a generator instead, with the same behavior:

```python
def range_iterable(start, end):
    while start < end:
        yield start
        start += 1
```

What `yield` does is to instruct the object to remember its state, and return its
value through the `__next__()` method associated to it. When there are no more
lines of code to execute, it raises `StopIteration`

> Note: as opposed to a list, once a generator is "exhausted", it cannot be looped
> over again.

# 2 - Generators

A generator is a function that runs some code, returns a value, but does not complete
its execution; it simply "pauses", waiting to be resumed. As simple as that. Generators
can be used as iterables (to iterate through a dataset), or to run asynchronous code.

## 2.1 Defining a generator

Generators are defined with the `yield` keyword, which instead of erasing the function
from the memory stack (what `return` does), tells the function to remember the state
of the generator for it will be called again. When it is called, it will resume
processing from the point in time where it left.

Example of a generator returning a set of integers;

```python
def numbers(start, end):
    for num in range(start, end + 1):
        yield num
```
- Defines a generator called `numbers()`.

## 2.2 Using generators

Following the above example: Now, unlike a function, running `numbers(1,3)` will not
return some code, rather, it will return a generator object.

To use a generator, we must associate a variable to it, and then call `next()`:

```python
g = numbers(1, 5)
next(g)
```
- Will return the first value (until the `yield` keyword) of the generator

When the generator is "exhausted" (no more values to yield), if `next()` is called, the
generator will return a `StopIteration` exception.

## 2.3 Useful funtions for generators

Iterating through a generator:

```python
for element in generator():
```

Returning a list with all the elements returned by the generator:
```python
list(generator())
```

## 2.4 Generator comprehension

Easy way to create a generator:

```python
generator = (element*2 for element in [1,2,3])
```
- Defiles a generator object "on the fly"

## 2.5 Generator pipelines

One of the most useful features of generators is their capcity link their outputs,
forming pipelines of data processing. When a generator is created, its data can be
used in another generator successively (without executing the processing). All data
is processed lazily when a function requests the output of the last generator of the
pipeline: all generators get called and executed the needed steps.


Example: using generators to count the quantity of data transferred by a server:

- Assuming there is an `access.log` file: (we want the sum of the last column)
```txt
81.107.39.38 - ... "GET /ply/ HTTP/1.1" 200 7587
81.107.39.38 - ... "GET /favicon.ico HTTP/1.1" 404 133
81.107.39.38 - ... "GET /ply/bookplug.gif HTTP/1.1" 200 23903
81.107.39.38 - ... "GET /ply/ply.html HTTP/1.1" 200 97238
```

Using generators we can do:
```python
with open("access.log") as file:
    bytecolumn = (line.split(" ")[-1] for line in file)
    nbytes = (int(number) for number in bytecolumn if number != "-")
    print("Total bytes:", sum(nbytes))
```
- The generators' `__next__()` function gets called recursively (the `sum()` triggers
  it).

## 2.6 The `yield` statement

Operating Systems use "traps" in processes to switch tasks very fase. "Traps" are
statements that pause a process, and gives back control of the CPU to the OS, which
then decides what process to continue running. The `yield` statement is like a "trap":
when a generator function runs `yield`, it immediately suspends execution and gives
back the control to its caller.

> Note: concurrency can also be used to "fake" multitasking.

# 3 - History of coroutines: Python 2.5 to 3.4

> Note: [this presentation](http://dabeaz.com/coroutines/Coroutines.pdf) is an amazing
> resource.

## 3.1 Coroutines as modified generators

### The modified `(yield)` statement

Coroutines are "modified generators" used for asynchronous code. They appeared when
the `(yield)` expression appeared in python, which "paused" execution until a process
sent data to the generator, which could then use that data to do some computation.
Unlike older generators, these modified ones were not required to return values
iteratively. This is the main difference: while generators "generate" data, coroutines
"consume" data to perform some computation.

Let's illustrate this with an example, defining a "modified generator" that only returns
a set of data if it contains a pattern. Can be seen as a "grep" implementation in Python.

```python
def grep(pattern):
    print("Searching for %s in strings", pattern)
    while True:
        line = (yield) # line will be equal to whatever value we send to the generator
        if pattern in line:
            print(line)
```
- This generator when created, expects the `next()` function to get exectuted until the
  `(yield)`, then, it needs `send(data)` to continue executing

See the behaviour above:
```txt
>>> g = grep("beatles")
>>> g.next()
Searching for beatles in strings
>>> g.send("This is a sample string")
>>> g.send("This is another sample string")
>>> g.send("Ladies and gentlemen: the beatles!")
Ladies and gentlemen: the beatles!
```

> Note: this `(yield)` statement can be set equal to a variable while yielding something
> at the same time. If we used `line = (yield "Hello!")`, every step we ran `send()`, a
> `"Hello!"` string would have been returned. This behavior is confusing and should be
> avoided.

As we can se above, this generator, rather than create data, only gets executed when
data is send to it. It can be said that it "awaits" some data. This is a couroutine.

> Note 2: as shown above, all coroutines need to be "primed": first, extantiated, and
> then `next()` needs to be run one time to start computing until the first `(yield)`
> appears. Then, it will get executed every time `send()` is called. This was achieved
> by the `@coroutine` decorator -> automatic call on `.next()` when coroutine is
> created.

> Note 3: although coroutines could be mimicked by a class that supports `send()`,
> coroutines (function-like definition) are far faster (optimised and do not need
> lookups to `self`).

### Closing a coroutine

Coroutines can run indefinitely, that is why it is possible to close them (remove them
from memory):

```python
coro.close()
```
- This function raises a `GeneratorExit` exception on the coroutine and stops it. Note
  that this exception can be called inside of a coroutine in order to perform some
  computation when it completes.

```python
def coroutine():
    print("Starting coroutine...")
    try:
        while True:
            a = (yield)
            print(a)
    except GeneratorExit:
        print("Ending coroutine. Goodbye!")
```

### Throwing exceptions

Exceptions can be also throwed inside of a coroutine as shown below:

```python
coro.throw(RuntimeError, "You are screwed!")
```

## 3.2 Coroutine pipelines

The same way as generators are linked through their `__next__()` methods, coroutines
get chained through their `send()` method. There is a slight difference: coroutines
need a *source* (typically not a coroutine) and a *sink*:
- The *source* is an entity that generates data and calls `send()` for the first time.
  This call will send some data to the first coroutine, triggering a chain of `send()`
  calls through the coroutine pipeline, until it reaches the *sink*.
- The *sink* is a coroutine that gathers all the data and does some action, without
  sending data anywhere.
- Regular coroutines (in-betweeen the *sink* and the *source*) should both receive
  data though `(yield)`, and send it to another coroutine with `send()`.

> Note: while generators "pull" data (only executed when last step of the pipeline asks
> for it), coroutines "push" it: the chain of coroutines gets executed once some data
> is sent to the first one.

> Note 2: coroutine pipelines can have multiple branches (a coroutine can send data to
> multiple destinations). Sending data to multiple sources is called "broadcasting", and
> can be arbitrarily complex, although no loops are allowed.

Example of a very simple *source*:
```python
def source(target_coro):
    i = 0
    while 1 < 20:
        target_coro.send(i)
        i =+ 1
        time.sleep(5)
```

Example of a *sink* coroutine:
```python
@coroutine # Instantiates it, then calles `__next__()`
def sink():
    try:
        while True:
            item = (yield)
            print("The received item is %s", item)
    except GeneratorExit:
        print("Sink coroutine closed")
```
- We can now run `source(sink())` to execute the chain of events.

# 4 - Coroutines after Python 3.5

The Python language introduced native support of coroutines in the 3.5 version of the
language. Although `asyncio` is the framework that popularized it, there are many
other event loops that could use coroutines with this update.

## 4.1 The `__await__` dunder method

All awaitable objects in Python now implement the `__await__` dunder method, which
should return an iterator.

## 4.2 The `async`/`await` syntax

In Python 3.5, the original `@asyncio.coroutine` decorator and `(yield)` statements
became obsolete in favor of the native support of Coroutines by the language. Instead
of the old implementation, the `async` and `await` keywords were added to the language, 
adding some additional constraints to it.

### The `async` statement

The `async` statement defines a coroutine that will need to be awaited.

This statement will:
- create a coroutine instance (rather than trying to execute the code) when the
  coroutine is instantiated.

A coroutine defined with `async` will add the following constraints:
- All functions using this keyword need to be awaited (otherwise a warning is raised).
- Coroutines can only `return` or `await` (not `yield`)
- If `yield` is used, the object will be an `async_generator` (not a coroutine, hence
  cannot be awaited)

Example: defining a coroutine
```python
async def coro():
    print("This will be printed when coro starts")
    data = await func()
    print(data)

async def func():
    time.sleep(2)
    return "Hello!"

print("Running...")
asyncio.run(coro())
```
- The above code will create a coroutine that awaits the result from `func()`. It will
  then print the result once it becomes available.

### The `await` statement

This statement somewhat replaces `(yield from ...)`, which basically gives back control
of the process to the scheduler (also called "event loop") until a result from a certain
source has been received. 

This works slightly differently as the previous implementation with `(yield)`, which
awaited `send()` call from any source. With `await`, we notify in the coroutine itself
the source of the data: "call me back when this has ben resolved". `await` also adds the
restriction that only coroutines can be awaited.

Once `await` is used, the scheduler pauses the coroutine and will decide later when it
gets some computing resources; it will do so only when the result of this `await` has
been resolved.

Await adds the following constraints:
- The object awaited needs to be awaitable (defile an `__await__()` method, which should
  return an iterator that is NOT a coroutine).

> Note: for all `asyncio` coroutines, the `__await__` method implements `__iter__`.

Example of awaiting something for data:
```python
async def coro():
    data = await function()
    return data
```

## 4.3 Tasks

Tasks are wrappers around coroutines that enable cancellation. Tasks can be awaited
(regular behavior -> same as a coroutine). Once the task is cancelled, it will throw
a `CancelledError`.
