# Debugging in Python


# 1 - The `pdb` module
`pdb` is a debugging library that allows us to interact with the code through the CLI. We set up break points with `pdb.set_trace()`, and the code will stop executing at that point, allowing us to check the values of variables at that point. We can type:
* `c` (for ‘continue’) in the CLI to go to the next break point we set up (works well in a loop too).
* `n` (for ‘next’) to simply execute the next line of the code (hence understanding it line by line). Note that `n` will not enter other contexts (ex: functions called), for that we use `s`
* `s` (for ‘step’) to execute the code line by line, including the next context (ex: entering inside functions or Classes defined) so that we can debug them. To use only if we are not sure the Class or function does not behave as it should.
* `l` (for ‘line’) to see which line we currently are inspecting in the code (shown by a `->`)
* `h` (for ‘help’) to see all available commands

# 2 - Python’s logging module
The logging module allows us to write logging events with different levels of severity: 
* `debug()`: lowest level of criticality
* `info()`
*  `warning()`
*  `error()`
*  `critcal()`: highest level of criticality

We set up these logging statements in our code, and the module allows us to turn on or off certain type of warnings (ex: if we do not need debug statements anymore, we can disable them instead of deleting all the lines).

Example (only taking logging statements from info level and beyond):
```python
import logging

logging.basicConfig(level=logging.INFO)

logging.debug('This will be ignored')
logging.info('This should be logged')
logging.warning('This should be logged too')
```
> Note: the default level of severity is `warning`; we can also set up our own levels of severity  

If we want to save the log statements in a file, we should use:
```python
import logging

logging.basicConfig(level=logging.INFO, filename = 'filename.log')
```
> Note: the default, is to open the file as `a` (append), so that we do not lose logs. We can also set it up `filemode = ‘w’` to wipe the logs before every new program run.  

Adding a timestamp and severity to the logs:
```python
import logging

logging.basicConfig(level=logging.INFO, filename = 'filename.log', format= '%(asctime)s  %(levelname)s:%(message)s')
```
* If we want a more specific date format, we can add the `datefmt` argument to it up. Example: `datefmt=‘%d/%m/%Y %I:%M:%S %p’` 

# 3 - Benchmarking with `timeit`
Benchmarking means checking how much time a block of code takes to run compared to other blocks.
> Note: different executions will take different times (depending on what the computer is running); the minimum time is the one to be retained  

Example: comparing getting a value from a dictionary directly with the key, or with the `get()` method:
```python
import timeit

print('query by index:', timeit.timeit(stmt="my_dict['c']", setup= "my_dict={'a':1,'b':2,'c':3}", number=1000000)
print('query by get:', timeit.timeit(stmt="my_dict['c']", setup= "my_dict={'a':1,'b':2,'c':3}", number=1000000)
```
* `stmt` is the operation to test, `setup` is the operation needed to run beforehand, `number`  is the number of times the operation is ran; the result is in ms.
* We can do the same from the CLI: using `python -m timeit -n 1000000 -s "my_dict={'a':1,'b':2,'c':3}" "my_dict['c']"`: `-m` is the module imported (`timeit`), multiple lines of code can be tested using triple quotes.
 
Example2: testing a function:
```python
import timeit

def test_me(this_dict, key):
	return this_dict[key]

timeit.timeit("test_me(my_dict, key)", setup= "from __main__ import test_me; my_dict={'a':1,'b':2,'c':3}; key = 'c'", number=1000000)
```
> Note: tests run on its own namespace, it needs to objects tested to be imported.  
