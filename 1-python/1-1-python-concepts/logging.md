# Logging and Debugging

# 1 - Python’s logging module

The logging module allows us to write logging events with different levels of severity: 
* `debug()`: detailed information, typically only used when diagnosing problems
* `info()`: confirmation that things are working as they should (logging "normal" behavior of the code, and actions performed)
*  `warning()`: an indication that something unexpected happened, or some problem in the near future (sur as "disk space low"). Software still working as expected.
*  `error()`: due to a problem, the software has not been able to perform a function requested.
*  `critcal()`: A serious error, indicating that the program itself may be unable to continue running. Highest level of criticality.

We set up these logging statements in our code, and the module allows us to turn on or off certain type of warnings (ex: if we do not need debug statements anymore, we can disable them instead of deleting all the lines).

## 1.1 Configuring `logging`
### 1.1.1 Setting up the severity

Example (only taking logging statements from info level and beyond):
```python
import logging

logging.basicConfig(level=logging.INFO)

logging.debug('This will be ignored')
logging.info('This should be logged')
logging.warning('This should be logged too')
```
> Note: the default level of severity is `warning`; we can also set up our own levels of severity  

### 1.1.2 Saving logs in a file

If we want to save the log statements in a file, we should use:
```python
import logging

logging.basicConfig(level=logging.INFO, filename = 'filename.log')
```
> Note: the default, is to open the file as `a` (append), so that we do not lose logs. We can also set it up `filemode = ‘w’` to wipe the logs before every new program run.  

### 1.1.3 Adding a timestamp to the logs

Adding a timestamp and severity to the logs:
```python
import logging

logging.basicConfig(level=logging.INFO, filename = 'filename.log', format= '%(asctime)s  %(levelname)s:%(message)s')
```
* If we want a more specific date format, we can add the `datefmt` argument to it up. Example: `datefmt=‘%d/%m/%Y %I:%M:%S %p’` 

### 1.1.4 Enabling `logging` in different modules

In order to have a specific logging configurations for different modules, the `logging` library allous us to instantiate a `LOGGER` object that will be specific to that module. We do so through the `getLogger()` function.
> Note: without instantiating `LOGGER` on each file, we would not be able to define different logging configurations for each, as one single `basicConfig` would be run, overriding the rest.

Defining the `LOGGER` object:
```python
LOGGER = logging.getLogger(__name__)
```
* Instantiates a `logger` object for the module, and gives it the Name of the module itself (saved in the magic attribute `__name__`). 

Once this object is instantiated, we can redirect the logs of the module through this object:
```python
LOGGER.info("This will be logged as INFO level.")
```
* Logs an output to the INFO layer of the module.

#### Logging from different modules into a file
In order to log elements of different modules on a single file, we must create logging file handler object, and add it to the `LOGGER` object:
```python
file_handler = logging.FileHandler("filename.log")

LOGGER.addHandler(file_handler)
```
* Adds the logs from the module to the "filename.logs" file.

We can specify the logging format in the file specifying a `format` object, and adding it to the `file_handler` instance with `setFormatter()`:
```python
formatter = logging.Formatter('%(levelname)s:%(name)s:%(message)s')

file_handler = logging.FileHandler("filename.log")
file_handler.setFormatter(formatter)

LOGGER.addHandler(file_handler)
```
* Adds a `file_handler` object to writ the logs in a file, and sets the format of these logs with the `formatter` object.
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
