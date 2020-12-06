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

Example of asynchronous "Hello World":

```python
import asyncio

async def hello_world():
    print("hello")
    await asyncio.sleep(1)
    print("world")

asyncio.run(hello_world())
```
- When `asyncio.run(hello_world())` gets executed, the coroutine gets executed: prints
  "hello", waits one second, then prints "world". This is achieved with
  `asyncio.sleep(n)`, which will wait n seconds to return None.

## 1.2 Tasks

`asyncio.Task` is a wrapper around a coroutine that adds some features to it, as well
as making it run in a non-lazy way: all the code that can be executed will be, awating
for the moment it is requested by another task.

A task is created using `asyncio.create_task(coro())` or `asyncio.ensure_future(coro())`
(both do the same). This will perform all needed actions and save the result into a
future, which will then be passed onto a coroutine when it awaits it. The `Task` wrapper
also enables an API to check if it has completed, add callbacks to it, or cancel it.

To create a task:
```python
task = asyncio.create_task(coro()) # or alternatively `asyncio.ensure_future(coro())`
```
- The task is now scheduled. Once the event loop starts, all tasks will run their code
  until an `await` is encountered.

> Note: while coroutines will be stacked as functions (if a coroutine is entered, all
> remaining code will not be executed until the await succeeds), tasks behave more
> optimally. For example, if a task awaits the result of two functions, it will first
> execute the first function awaited, and while that function processes, it will start
> processing the second one. Even if the second one returns before the first, the order
> in the task is maintained.

See this below example to compare coroutines and tasks:
```python
import time
import asyncio
from datetime import datetime

async def timeout(seconds):
    print(f"Starting to wait {seconds} seconds.")
    time.sleep(seconds)
    return f"Processed {seconds} seconds"

# coroutine implementation
async def main():
    start = datetime.now()
    print(await timeout(5))
    print(await timeout(2))
    end = datetime.now()
    print(f"{end-start} time elapsed")

# task implementation
async def main_task():
    start = datetime.now()
    task1 = asyncio.create_task(timeout(5))
    task2 = asyncio.create_task(timeout(2))
    end = datetime.now()
    print(await task1)
    print(await task2)
    print(f"{end-start} time elapsed")


print("Running coroutine imp...")
asyncio.run(main())

print("Running taks impl...")
asyncio.run(main_task())
```

The different behavior can be noted in the output produced by the above code:
```txt
Running coroutine imp...
Starting to wait 5 seconds.
Processed 5 seconds
Starting to wait 2 seconds.
Processed 2 seconds
0:00:07.009012 time elapsed
Running taks impl...
Starting to wait 5 seconds.
Starting to wait 2 seconds.
Processed 5 seconds
Processed 2 seconds
0:00:00.000027 time elapsed
```
- The event loop "waited" for 7 seconds in the first coroutine, while the second one
  awaited for zero seconds, as the results from the tasks were computed in a non-lazy
  way (were computed initially, then inserted).

## 1.3 Futures

Futures (very similar to JavaScript Promises) are low-level awaitable objects that
represent the eventual result of an asynchronous operation. All coroutines await
for futures; normally there is no need to define futures in the application level.

## 1.4 Events

Check the [`asyncio.Event` documentation](https://docs.python.org/3/library/asyncio-sync.html#asyncio.Event).

Events are very useful objects in `asyncio` to notify or block a coroutine until some
event has happened.
Events are created with its simple constructor:
```python
event = asyncio.Event()
```
- Creates an `asyncio.Event()` instance that can be awaited by a couroutine to continue
  executing, and succeeded

### Waiting for an event to be succeeded 

To block a coroutine until an event happens:
```python
event = asyncio.Event()

# Block coroutine until event succeeds.
await event.wait()
```
- Will wait until the `event` is `set()`; the `await` will return `True` (internal flag)

Another way of awaiting an event is wrapping it in an `asyncio.Task`:
```python
waiter_task = asyncio.create_task(waiter(event))

# Block coroutine until event succeeds.
await waiter_task
```
- Will wait until the event succeeds.

### Succeed an event

```python
event.set()
```
- Sets internal flag to true (succeeds all processes awaiting for it)

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


# 5 - Awaiting multiple tasks

There are two ways of awaiting for multiple tasks:
- `asyncio.wait(List[Task], return_when=option)`: will wait for an event in all
  the routines to return all of them.

## 5.1 Gather

Check documentation
[here](https://docs.python.org/3/library/asyncio-task.html#running-tasks-concurrently).

```python
asyncio.gather(List[Task], return_exceptions: bool=Fals)
```
- Creates a combined task that will wait for all `Task`s to complete, unless any of
  them throws an `asyncio.CancelledError`. If `gather()` is Cancelled, all the tasks
  inside of it (which have not completed yet) are cancelled as well.
  - `return_exceptions` is a boolean flag; if `False` (default), it propagates the
  exception thrown by any of the `Task`s to the aggregated Task. The remaining tasks
  will continue running. If `True`, exceptions are treated as successful results and
  aggregated in the result list.

## 5.2 Wait

Check the documentation
[here](https://docs.python.org/3/library/asyncio-task.html#waiting-primitives).

```python
asyncio.wait(List[Task], return_when=option)
```
- Creates an aggregated task that will await for a condition to be resolved to complete;
  the condition is specified in the `return_when` argument. Uncompleted tasks are not
  cancelled.
  - Possible values of `return_when`:
    - `FIRST_COMPLETED`: function returns (completes) when any future completes or
  is cancelled
    - `FIRST_EXCEPTION`: function returns when any future finishes by raising an
  exception
    - `ALL_COMPLETED`: function returns when all futures complete or are cancelled
