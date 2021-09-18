# AsyncIO


`asyncio` is a Python package that allows concurrent code using the `async`/`await`
syntax, which is perfect for IO-bound processes (ex: awaiting for network responses
or writing files to the DB). Check the
[official documentation](https://docs.python.org/3/library/asyncio.html).

> Note: concurrency is the umbrella term behind threading and parallel processing,
> it is the idea of running tasks in an overlapping manner (either in a separate
> thread, or in a different CPU)

`asyncio` is single-threaded and single-process, it uses cooperative multitasking to
run concurrent code. The way it works is by scheduling [`coroutines`](#11-coroutines),
concutrrently, but their execution is not inherently concurrent.

> Note: "asynchronous" in Python means that routines have an ability to "pause" its
> execution while waiting for a result.


`asyncio` provides a set of objects that allow:
- running python [`coroutines`](#11-coroutines) concurrently (when they are wrapped in 
  an [`asyncio.Task`](#12-tasks)) - most important point
- perform network IO and IPC ([Streams](#2---streams))
- distribute tasks via [`queues`](#3---queues)

# 0 - Basic concepts

## CPU vs I/O bound

In programming, a task can have two bottlenecks:
- The CPU (the task is CPU-bound) tasks, for example, matrix multiplication
- Reading Input or producing an Output (the task is I/O-bound), for example,
  downloading a very large file from the internet.

In Python we use different strategies for CPU-bound or I/O-bound tasks.

Since Python is a single-threaded programming language, the only way of speeding
CPU-bound tasks is through multiprocessing (using more CPUs).

I/O bound tasks, in which a single thread blocks all the process for a long time waiting
for some missing information, can be sped up in Python using:
- `threading`: in which other tasks can keep processing while others are blocked (there
  is an improvement from a complete blockage but is not optimal).
- `asyncio`: in which the main thread looks for other parts of the code that can be run
  while waiting for calls to be resolved (if written properly, can improve performance
  substantially).


> Note: Although the `threading` module in Python enables running separate threads,
> what happens in the background is that the CPU switches between each thread really
> fast, giving the illusion of parallelization. Everything happens as a single thread
> in one single worker of a CPU.

## The event Loop

The main concept that `asyncio` brings is an event loop. The event loop is what will
control the code execution. Independent functions, wrapped in tasks, are scheduled in
the event loop. The event loop will run the first task until an `await` keyword is
reached. At that point, the event loop will switch to execute the second task. When the
first `await` statement succeeded (some data was received), the first task can resume
its execution from the point where it left.

For the event loop to work properly, running code concurrently, the asynchronous
functions (also called coroutines) need to be wrapped in an `asyncio.Task`. Otherwise
the code will not work in a concurrent way (tasks are what hand over the control back
to the event loop).

> Note that the even if code is run concurrently, the event loop will ensure the
> final execution will run in the specified order.
# 1 - Awaitables

There are three types of awaitables: Coroutines, Tasks, and Futures. Check
[this section](https://docs.python.org/3/library/asyncio-task.html#creating-tasks)
of the official documentation.

## 1.1 Coroutines

In general terms, a coroutine is nothing more than a function that can pause its
execution until reaching `return`, and it can pass control to another coroutine
for some time.

Coroutines are the way functions are defined to run concurrently in Python. Coroutines
are similar to regular functions, in the way that if they are sent unexecuted, they
are still a `function` object. But as opposed to functions, if executed, coroutines
return a `coroutine` object (which can be scheduled) rather than running the code
itself. This behavior enables the event loop to take control of its execution.

As mentioned above, coroutines are asynchronous objects that do not run when they get
instantiated, rather, they need to be ran with the `asyncio.run(coroutine())` method
(or when they are awaited by another coroutine). 
To define a coroutine, we use the `async` (mandatory) and `await` (otpiona) keywords:
- `async` will define the object as a coroutine
- `await` will stop the coroutine's execution until the object awaited has completed
  (returns something). This behavior, if the coroutine is wrapped around a `Task`,
  enables to execute some code while waiting for that statement to get the data it
  needs to continue.

Example of asynchronous "Hello World":

```python
import asyncio

async def hello():
    print("hello")
    await asyncio.sleep(1)
    print("world")

async def main():
    await asyncio.gather(hello(), hello(), hello())

if __name__ == "__main__":
  asyncio.run(main())
```
- The above code allows to run three times the `hello` function asynchronously. The
  `await asyncio.sleep(1)` call will give control back to the event loop for one second,
  allowing it to execute other tasks (in this case, the execution of the other two
  `hello` functions).

> Note: `asyncio.sleep(n)` is a coroutine that waits `n` seconds to return `None`

> Note: `asyncio.gather()` takes the coroutines passed as arguments and wraps them
> into [tasks](#12-tasks) to run them concurrently.

## 1.2 Tasks

### Defining a task

`asyncio.Task` is a wrapper around a coroutine that enables the event loop to switch
between them, as well as making them run in a non-lazy way: all the code that can be
executed will be, awating for the moment it is requested by another task.

Example:
```py
async def a_coroutine_function() -> int:
    await asyncio.sleep(1)
    return 23

my_task = asyncio.create_task(a_coroutine_function())
```
- Creates a task and schedules it to run as soon as it is possible (adds it to the
  queue of the `asyncio` event loop).

> Note: this will only schedule the task and run all the code it can, but the
> execution will not be await until it is completed. To await the execution of a task
> until it finishes, we can use the `await` keyword.

```py
await my_task
```

A task is created using `asyncio.create_task(coro())` or `asyncio.ensure_future(coro())`
(both do the same). This will perform all needed actions and save the result into a
future, which will then be passed onto a coroutine when it awaits it. The `Task` wrapper
also enables an API to check if it has completed, add callbacks to it, or cancel it.

> Note: while coroutines will be stacked as functions (if a coroutine is entered, all
> remaining code will not be executed until the await succeeds), tasks behave more
> optimally. For example, if a task awaits the result of two functions, it will first
> execute the first function awaited, and while that function processes, it will start
> processing the second one. Even if the second one returns before the first, the order
> in the task is maintained.

### Running tasks concurrently

To run several tasks concurrently, we can schedule all of them, then call await for
each one of them. `asyncio` provides some help in this aspect with constructs that
enable, for example, awaiting for a group of tasks until all succeeded.

#### Awaiting a group of tasks

`asyncio.gather()` is one of the basic constructors that `asyncio` provides, it expects
a list of tasks; will execute them concurrently until all of them succeed. Then, it
will return an iterable with all the

```py
asyncio.gather(a_coroutine_function_1(), a_coroutine_function_2())
```
- Returns an iterable with all the results of each of the coroutines when all coroutines
  complete. The coroutines are ran concurrently.

### Example

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

`asyncio` queues are designed to work similarly as the ones from the `queue` module,
with the difference that the consumer can now `await` for an item to arrive in
the queue.
`asyncio` adds the functionality of working with coroutines (queues can now be
awaited). Check the `asyncio` queue section
[here](https://docs.python.org/3/library/asyncio-queue.html#asyncio-queues).

> Note: `queue.Queue` provides thread safety while `asyncio.Queue` does not, `asyncio`
> does not need it. It runs in a single thread.

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
