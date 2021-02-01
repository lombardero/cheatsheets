# Debugging in python

# 1 - `pdb`, the Python Debugger

`pdb` is the official python debugger (which is part of the Python package since `3.7`).

It enables to add breakpoints in the code (by simply adding the `breakpoint()`
statement), then, when the code is run through the CLI, the execution will halt at
that statement, from which we can control the execution from the CLI.

## 1.1 Adding breakpoints in the code

From Python 3.7 onwards, we can create a breakpoint in the Python code:

```py
def some_function():
    # Some logic.
    breakpoint()
    # Some additional logic.
```

Before Python 3.7, the `pdb` module needed to be imported.
```py
import pdb

def some_function():
    # Some logic.
    pdb.set_trace()
    # Some additional logic.
```

## 1.2 Interacting with the debugger through the CLI

When the break point is reached, we can query data (such as variables or themcode being
executed) or control the execution through the CLI.

### Querying data

Show what is being executed:
- `w` ("where"): Show current stack trace
- `l` ("list"): Show source code being executed. Will output the lines of the source
  code pointing with a `->` the one after which the computation was halted.

Show variables:
- `a` ("args"): Show all currently defined arguments of the current function
- `pp <variable_name>` ("pretty print"): show any object currently in memory

Play around:
- `!<statement>`: execute any Python statement (run functions, etc.)

### Control the code execution

Execute statements:
- `s` ("step"): execute next statement (will enter other contexts such as functions if
  called, and only run the first statement of that context).
- `n` ("next"): exevcute all statements (even complete functions) until following line
  of module is reached. Unlike `s`, will not enter contexts and reach the next line of
  the current context.
- `r` ("return"): execute all statements until current function returns.
- `c` ("continue"): go to the next break point we set up (works well in loops)

Ask for help:
- `h` ("help"): will show all available commands.
