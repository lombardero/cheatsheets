# Threading

Threading is a built-in library in Python that allows us to run code concurrently
(which is useful for IO-bound tasks). With threading, we can trigger functions
in an asynchronous way to not block the main thread of the script.

# 1 - The `threading` module

## 1.1 Starting threads

`threading` is a built-in Python package that enables us to run functions outside of
the main thread of the script through the `Thread` class. Because of the Python
interpreter (which cannot run several threads at a time due to its memory collection
system), the `threading` module will implement an "illusion" of threading rather than
running two actual threads in the computer (meaning the `threading` mdule in
Python is only truely useful for I/O bound tasks).


Example: running a function in a separate thread
```py
import threading
import time

def do_something(x):
    time.sleep(x)
    return "Done sleeping!"

t1 = threading.Thread(target=do_something,args=[2])
t2 = threading.Thread(target=do_something,args=[1])

t1.start()
t2.start()

# threads t1 and t2 will be "detached" from the main thread and run separately.
```
- The `threading.Thread()` wrapper returns a "thread" object from which we can trigger
  the targetted function to run in a separate thread. This thread will run separately,
  and finish its processing independently
- The `t1.start()` triggers the function to be executed, without blocking the current
  thread.

> Note: the `Thread()` wrapper expects an unexecuted function (without parenthesis)

## 1.2 Awaiting completion of threads

If at some point we want our main thread to await the completion of one of the threads
we created, we can do use `thread.join()`:

```py
t1 = threading.Thread(target=do_something,args=[2])
t2 = threading.Thread(target=do_something,args=[1])

t1.start()
# Triggers t1.

t1.join()
# Awaits for t1 to complete to continue the main thread.
```

## 1.3 Stopping threads

### Raising an exception

In the above example, the `do_something()` function performs some action, then ends,
and therefore closing the thread. However, there can be cases where functions have
a `while True` statement, which means they will keep active unless killed. This
means that we will have to close the thread explicitely (though the object). This
is usually done by raising an exception in the thread (the thread needs to be
prepared for it).

```py
def do_something(x):
    try:
        # Regular functioning of the thread.
        while True:
            time.sleep(x)
    finally:
        # What to do when an exception is raised.
        print("Thread ended!")

t1 = threading.Thread(target=do_something,args=[2])

# Start the process.
t1.start()

# Do some computation.
time.sleep(200)

# Stop the thread.
t1.raise_exception()
t1.join()
```

### Using daemon processes

An alternative way of stopping threads created from a script is to open daemon
threads. A daemon thread will always be killed automatically when the main thread
that called it completes. If we want to wait for a daemon thread to complete, we
can do so through the `thread.join()` method.

A thread can be created as daemon through `thread.setDaemon()` method:

```py
# Creates t1 as daemon.
t1 = threading.Thread(target=do_something,args=[2], daemon=True)

t1.start()
```

# 2 - The `concurrent.futures` module

This module (added in 3.2 release), introduced a context manager to run different threads easily, and switch
between threading and multiprocessing.

Example: running the `do_something()` function as in the point 1
```py
import concurrent.futures

with concurrent.futures.ThreadPoolExecutor() as executor:
    # Schedules an execution of `do_something()`, creating a future object `f1`.
    # Through `f1` we can check if the function completed, and await for it to
    # return something.
    f1 = executor.submit(do_something,2)

    # The `.result()` method enables us to await for a result.
    f1.result()
```

# 3 - Locks

One of the classic issues of the `threading` library is the utilisation of
non-thread-safe resources. For that, the `threading` library introduces a `Lock`
class that blocks a second thread requesting to use a resource until the first
thread releases it:

```py
import threading
import time

class SharedResource:
  
    def __init__(self):
        self.value = 0
        self.lock = threading.Lock()

    def read_value(self, caller: str):
        print(f"{caller} read value of {self.value}")
        return self.value

    def set_value(self, value: int, caller: str):
        print(f"{caller} set value of {value}")
        self.value = value


r = SharedResource()
def process(name: str):
    r.lock.acquire()
    read_value = r.read_value(name)
    read_value += 2
    time.sleep(0.1)
    read_value = r.set_value(read_value, name)
    r.lock.release()

t1 = threading.Thread(target=process, args=["T1"])
t2 = threading.Thread(target=process, args=["T2"])

t1.start()
t2.start()
```
- The use of `lock` bove allows to access the `SharedResource()` by two different
  threads without corrupting the final result (which should be 4)
