# Simpy

`simpy` is an open-source Python library that enables discrete-event simulations.
It defines a series of event-driven building blocks that allow us to build the models.

Check the official documentation
[here](https://simpy.readthedocs.io/en/latest/index.html), or follow the
[tutorial](https://simpy.readthedocs.io/en/latest/simpy_intro/basic_concepts.html).

# 1 - Simulation building blocks

## 1.0 Environment

The `Environment` is the "simulation space" where the simulation occurs. All the
processes and events will live in one `Environment` instance:

```python
env = simpy.Environment()
```
- Creates an `Environment` instance: now `env.process(<generator>)` can be called to
  schedule a process inside of it. The simulation can be run using `env.run()`
- Methods:
  - `proc = env.process(<generator>)`: creates process instance in the simulation
  - `event = env.event()`: creates an event instance in the simulation. Events block
    the execution of processes. When a process yields an event, it will wait for it
    to fail or succeed. Once it does, the process will continue. Events can be
    failed or succeeded using `event.succeed()` or `event.fail(<exception>)`

## 1.1 Processes

### General idea

Processes are defined by simple Python `generators` (check
[this resource](https://jeffknupp.com/blog/2013/04/07/improve-your-python-yield-and-generators-explained/)),
which can be functions or methods of a Class. Processes yield `Event` or other
processes, and then get suspended until these events complete. Processes can be
called through other processes as well. Multiple processes can wait for a single event.

> Note: processes are also `Event`s

Define a process instance on an environment:
```python
def my_process(env):
    """Simulates a process that does A, then B."""
    while True:
        print('Simulate A')
        duration_A = 3
        yield env.timeout(duration_A)

        print('Simulate B')
        duration_B = 1
        yield env.timeout(duration_B)


proc = env.process(my_process(env))
```
- Creates a process that models actions A and B (needs `env` as an argument since it
  does a `timeout`), then schedules it in the environment. A process instance `proc`
  is created (so that we can interact with it, and call it).

> Note: `env.timeout(n)` stops the simulation `n` seconds, then continues running the
> process again. `SimPy` does it by creating a timeout event that yields the process
> that called it once it completes the timeout.

For more complex logic, the best way is to define processes through Classes:
```python
class Car:
    def __init__(self, env):
        self.env = env 
        self.action = env.process(self.action())
    
    def action(self):
        # main logic of the Process
```

### The use of `yield` in `SimPy`

`yield` can be seen as a breakpoint on a process. Yielding an event or a process
will start the process, and the function or process that called it will be stopped
until that process has finished.

*Example:* yielding a process will instantiate it, and wait for it to finish for
the original process to continue running:

```python
class ElectricCar:
    def __init__(self, env):
        self.env = env
        self.drive_proc = env.process(self.drive(env)) # Instantiates drive process (1)

    def drive(self, env):
        while True:
            # Drive for 20-40 min
            yield env.timeout(randint(20, 40)) # Simulates driving (2) -> stops process until
                                               # timeout is complete

            # Park for 1–6 hours
            print('Start parking at', env.now)
            charging = env.process(self.bat_ctrl(env)) # calls `bat_ctrl` after some seconds (3),
                                                       # creates a `charging` process variable
                                                       # (which is a timeout(randint(30,90)))
            parking = env.timeout(randint(60, 360)) # creates a timeout event (5)
            yield charging & parking # Will wait for both processes to end before continuing (6)
            print('Stop parking at', env.now)

    def bat_ctrl(self, env):
        print('Bat. ctrl. started at', env.now)
        # Intelligent charging behavior here …
        yield env.timeout(randint(30, 90)) # Simulates charging (4), waits some seconds
        print('Bat. ctrl. done at', env.now)
```

> Note: `process1 & process2` will wait for both process to finish to complete, while
> `process1 | process2` will wait for one of them to complete. 

### Interrupts

Processes can also be forcefully interrupted with `process.interrupt()`. Interrupting a
process which will throw an `Interrupt` exception on the current event yielded by that
process (the event the process was waiting to continue execution), and will resume the
process.

*Example:* Take the above example of `ElectricCar`. Imagine the electric car is waiting
for the battery to fully charged in order to leave the parking spot. If suddently there
was an urgent trip, we could use `bat_ctrl.interrupt()` to stop the `timeout(randint(30,90))`,
which would throw an `Interrupt` exception. Meanwhile, `bat_ctrl` would continue its execution
and stop the charging model.

## 1.2 Events

### Basics

Events (from the class `Event`) are very similar to promises, and used to simulate all
kinds of events of a simulation. An `Event` has three states:

- might happen (not triggered, just an object in memory of the simulation -> intial
  state),
- is going to happen, scheduled (triggered), and therefore inserted into SimPy's Queue
  (at this point, the attribute `Event.triggered` becomes `True`),
- has happened (popped out of SimPy's event queue, the event's callbacks are called)

Events can fail or succeed, raising an exception if it fails (use
`Event.fail(<exception>)`) to make it fail, and `Event.succeed()` to make it succeed.

### Callbacks

Callbacks are callable objects that get triggered once an event completes. The way of
defining an `Event` callback is through `yield`ing the `Event` in the process we
want to resume. 

*Example:* simulating of a person running, we want to model the amount of time he burns
calories. For that, we create a `burning_calories()` method that yields an event,
which succeeds once the person runs (therefore activating `burning_calories()`):

```python
class FitPerson:
    def __init__(self, env):
        self.env = env
        self.rest_or_run = env.process(self.rest_or_run(env))
        self.burning_calories = env.process(self.burning_cal())
        self.burning_calories_start = env.event() # Instantiate event at init (1) -> event
                                                  # will not complete until manually succeeded
        self.burning_calories_end = env.event() # Instantiate event at init (1') -> event
                                                # will not complete until manually succeeded

    def walk_or_run(self, env):
        # run for 10 mins
        while True:
            yield env.timeout(10)

            self.burning_calories_start.succeed() # Succeeds event -> calls process
                                                  # that called it -> runs `burning_cal` again  (3)
            self.burning_calories_start = env.event() # Starts up new event (so it can get yielded) (4)

            # sit for 10 min
            yield env.timeout(10)

            self.burning_calories_end.succeed() # Succeeds event -> enables `burning_call() to continue (6)
            self.burning_calories_start = env.event() # Creates new event (7) - and restarts from (2)

    def burning_cal(self):
        while True:
            print("Now I'm not burning")
            yield self.burning_calories_start # yield event -> stops `burning_cal` (2)

            print("Now I'm burning!!")
            yield self.burning_calories_end # after 2nd call, yields second event -> stops
                                            # `burning_cal` again (5)

```

The `Event` will trigger another Process or
Event, and that will be added to the simulation queue.
