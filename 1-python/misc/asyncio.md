# AsyncIO


`asyncio` is a Python package that allows concurrent code using the `async`/`await`
syntax, which is perfect for IO-bound processes (ex: awaiting for network responses
or writing files to the DB). Check the
[official documentation](https://docs.python.org/3/library/asyncio.html).

`asyncio` provides a set of objects that allow:
- running python [`coroutines`](#11-coroutines) concurrently (check [`asyncio.Task`](#12-tasks))
- perform network IO and IPC ([Streams](#2---streams))
- distribute tasks via [`queues`](#3---queues)


# 1 - Awaitables

There are three types of awaitables: Coroutines, Tasks, and Futures. Check
[this section](https://docs.python.org/3/library/asyncio-task.html#creating-tasks)
of the official documentation.

## 1.1 Coroutines

Coroutines are asynchronous objects that do not run when they get instantiated, rather,
they need to be ran with the `asyncio.run(<coroutine>)` method (or when they are
awaited by another coroutine). To define a coroutine, we use the `async` and `await`
keywords:
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

## 1.2 Tasks

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

## 1.3 Futures

Futures (very similar to JavaScript Promises) are low-level awaitable objects that
represent the eventual result of an asynchronous operation. All coroutines await
for futures; normally there is no need to define futures in the application level.


# 2 - Streams

Streams are coroutines that interact with Network connections, allowing
to send and receive data. Check the documentation
[here](https://docs.python.org/3/library/asyncio-stream.html#asyncio-streams).


# 3 - Queues

`asyncio` queues are designed to work similarly as the ones from the `queue` module.
`asyncio` adds the functionality of working with coroutines (queues can now be
awaited). Check the `asyncio` queue section
[here](https://docs.python.org/3/library/asyncio-queue.html#asyncio-queues).

# 4 - `aiojobs`

`aiojobs` is a library that brings two objects built on top of `asyncio`, which add two
features:
- `Job`: a wrapper of a `asyncio.Task` that allows it to be placed in a `Scheduler`
- `Scheduler`: a container for `aiojobs.Job` that allows to specify a concurrency
  limit. `Job`s inside a `Scheduler` can be enumerated and closed.

Creating a `Scheduler` object, then creating a `Job` inside of it:

```python
scheduler = await aiojobs.create_scheduler()

job = scheduler.spawn(<coroutine>)
```
- Once a `Job` is spawned, it will start immediately (or pushed to the pending queue if
  concurrency limit exceeded).

Gracefully shutting down all jobs in the `Scheduler`:
```python
await scheduler.close()
```
- Will wait a timeout of 0.1 seconds, and gracefully shut down all jobs (if job is not
  finished when method called, it is listed in `scheduler.call_exception_handler()`).

Explicitely waiting to complete jobs:
```python
await scheduler.wait(n)
```
- Will wait `n` seconds before attempting to gracefully shut down the jobs in the
  scheduler.



