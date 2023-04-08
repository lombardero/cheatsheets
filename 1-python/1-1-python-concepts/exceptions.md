# Exceptions

Built-in python exceptions [documentation](https://docs.python.org/3/library/exceptions.html).

# 1 - Catching exceptions

## 1.1 - Try-except

In Python, we can execute some code when a certain type of exception is triggered with the `try`-`except` syntax.

> Note: Python stops all code execution when an error occurs, and prints out what went wrong. However, with the try-except syntax, the Error can be tracked and handled by our code directly, allowing to define a specific way of doing so.

Example of code that gets executed if a `KeyError` occurs:

```python
d = {'a':1, 'b':2}

key = input('Input a key')

try:
	print('Value of key is:{}'.format(d[key])
except KeyError:
	print('Sorry, the key {} is not defined'.format(key))

# Program keeps executing
```

- `except` gets called if the user input was not `’a’`or `’b'`.
  > Note: we can run code when different error types appear with this syntax: `except(IndexError, ValueError):` (for example)

## 1.2 - Enhancing the error messages with `raise`

Python will raise error types to guide the user to find the problem. Sometimes, however, it can be hard to figure out what is the problem. We can create code that helps the user to find out what is the issue with the `raise` operator, which will allow us to send a more specific message to the user.

> Note: `raise` works like `return`, the code will stop executing when it reaches it.

Example:

```python
def delim_line(list, delim)
	try:
		formatted_line = delim.join(list)
	except TypeError:
		raise TypeError('delim_line(): arg 1 must be a list or tuple')
	return formatted_line
```

- The above code allows us to send a more precise message in case a `TypeError` happens.

We can also get the exception object using this below syntax:

```python
	try:
		print(5/0)
	except ZeroDivisionError, e:
		print(e.message)
```

- `e` is an exception object that contains the `message` argument (message that would have displayed if the exception would not have occurred), and `args` is a tuple containing the message and other useful information (different for many types of errors).

Example of `raise` without `try`-`except`, function testing that input has a certain format:

```python
def date_format_check(date):
	if not re.search(r'^\d\d\d\d\-\d\d\-\d\d$', date)
		raise ValueError('Please submit date in YYYY-MM-DD format')
	print('Submitted date is {}'.format(date))
```

# 2 - Creating custom Exception types

Exceptions are Classes (like everything in Python), therefore, we can create a new Exception Class inheriting from built-in ones. We can do so for doing other things than simply printing the error (ex: logging the error, inspecting the object, etc.).

Two methods are automatically called when an exception is raised: `__init__` (initialisation) and `__str__` (action to do when the error is raised).

Example of a custom Exception (very similar behaviour as the built-in ones):

```python
class MyError(Exception):
	def __init__(self, *args):
		if args:
			self.message = args[0] #we store as a message attribute the first arg if there is one
		else:
			self.message = None

	def __str__(self):
		if self.message:
			return "MyError raised because: {}".format(self.message)
		else:
			return "MyError raised!"
```

- We can now use `raise MyError(’There is a problem’)` or `raise MyError` to raise it! (We can add more fancy stuff to do other than simply printing things.
  > Note: `*args` captures any number of args added and packs them in a tuple
