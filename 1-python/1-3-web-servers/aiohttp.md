# AsyncIO and AIOHTTP

# 1 - AsyncIO

`asyncio` is a Python package that allows concurrent code using the `async`/`await`
syntax, which is perfect for IO-bound processes (ex: awaiting for network responses
or writing files to the DB). Check the
[official documentation](https://docs.python.org/3/library/asyncio.html).

`asyncio` provides a set of objects that allow:
- running python [`coroutines`](#coroutines) concurrently (check [`asyncio.Task`](#tasks))
- perform network IO and IPC (?)
- control subprocesses (?)
- distribute tasks via `queues`


## 1.0 Concepts

### 1.0.1 Awaitables

There are three types of awaitables: Coroutines, Tasks, and Futures. Check
[this section](https://docs.python.org/3/library/asyncio-task.html#creating-tasks)
of the official documentation.

#### Coroutines

Coroutines are asynchronous objects that do not run when they get instantiated, rather,
they need to be ran with the `asyncio.run(<coroutine>)` method. To define a coroutine,
we use the `async` and `await` keywords:
- `async` will define the object as a coroutine
- `await` will stop the coroutine until the object awaited has completed (returns
  something).

Example of asynchronous "Hello World"

```python

import asyncio

async def hello_world():
    print("hello")
    await asyncio.sleep(1)
    print("world")
```
- When `asyncio.run(hello_world())` gets executed, the coroutine gets executed: prints
  "hello", waits one second, then prints "world"

#### Tasks

`asyncio.Task`s enable coroutines to await multiple running parts of the code at a
time. When a coroutine is wrapped into a Task, the event loop will schedule the task
concurrently to many others (Tasks will run in "parallel" (usually IO-bound, not
CPU-bound), increasing the code efficiency). Apart from this, `Tasks` can be
interrupted with an exception.

We use `asyncio.create_task(<coroutine>)` to define a task. Example:

```python
async def main():
    task1 = asyncio.create_task(
        asyncio.sleep(10))

    task2 = asyncio.create_task(
        asyncio.sleep(5))

    # Wait until both tasks are completed
    await task1
    await task2
```
- Using tasks allows the `main()` function to run in around 10 seconds (both tasks
  start at around the same time and get returned in order), rather than 15 seconds
  (which would have happened without wrapping them into as an `asyncio.Task`)

#### Futures

Futures (very similar to JavaScript Promises) are low-level awaitable objects that
represent the eventual result of an asynchronous operation. All coroutines await
for futures; normally there is no need to define futures in the application level.
