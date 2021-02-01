# Subprocesses in Python

The `subprocesses` module enables to run bash commands and capture their input and
output in Python.

# 1 - Running basic commands

## 1.1 Running a command

Running a basic command:
```py
import subprocess

subprocess.run(["ls", "-la"])
```
- The python code will run the `ls -la` on the shell.

> Note: the command will be run normally, without capturing any standard output (it
> will be directed to the shell as if we ran the command there)

If we set the running subprocess to a variable, we can check its return code:
```py
process1 = subprocess.run(["ls", "-la"])

print(process1.returncode)
```
- Will return `0` or `1` depending on the return code of the command

## 1.2 Capturing `stdout`

### Capturing in a variable
The `stdout` is sent to the console, to capture, we can do:

```py
process1 = subprocess.run(["ls", "-la"], stdout=subprocess.PIPE, text=True)

print(process1.stdout)
```
- Captures the `stdout` and attaches it to `process1`
> Note: the `text=True` option allows the `stdout` to be saved as text rather than
> bytes (ugly format - hard to read)
> Note2: we could replace the `stdout=subprocess.PIPE` by `capture_output=True` (it
> does the same in the background)

### Capturing `stdout` in a file


The `stdout` can be captured in a file directly:
```py
with open("file.txt", "w") as f:
    process1 = subprocess.run(["ls", "-la"], stdout=f, text=True)
```

# 2 - Run commands in a separate process

The `subprocess.run()` command runs a command and waits for it to finish. To support
communication with a running subprocess we can use `Popen`:

```py
from subprocess import PIPE, Popen

process = Popen(['<command>', '<command continuation>'], stdout=PIPE, stderr=PIPE)

stdout, stderr = process.communicate()
```
- `Popen` creates a process that runs the command but does not wait for it to complete,
  rather, its output can be accessed through the `.communicate()` method
> Note: the `subprocess.run()` actually uses `Popen()` in the background


