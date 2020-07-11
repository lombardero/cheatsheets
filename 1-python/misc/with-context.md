# The `with` context


# 1 - Basic use of `with`
`with` is an operator that allows us to create a block of code that will open a file, do some computation, and then close it when all that block of code has been executed (it is always better to close the files we opened to free up space). In other words, `with` enables to automatically execute some code when some object is created, and when the block is exited.

Example of “open file” functionality:
```python
fh = open('filename.txt')
for line in fh:
	print(line)
fh.close()
```

We can implement the same using `with`:
```python
with open('filename.txt') as fh:
	for line in fh:
		print(line)

# after the with, we can add any code that will be executed only when the with is completed
```

# 2 - Using `with` on a Class
The same way we used it with a file handler object, we can use `with` in our Classes to execute some code when the `with` block starts, and when it ends. For example, starting a network connection and closing it after the object has left `with`, or allocating a great deal of memory. This is what `with` is useful for. 
> Note: In order to use `with`, we need to define the `__enter__`and `__exit__` magic methods of our Class.  

Example that enables the use of with:
```python
class NewClass:
	def __enter__(self): #executed at the start
		print('we entered "with"')

	def __exit__(self, type, value, traceback):
		print('error type: {}'.format(type))
		print('error value: {}'.format(value))
		print('error traceback: {}'.format(traceback))

	def sayhi(self):
		print('hello, I am instance %s' % (id(self)))
```
* The enter method executes the code that will be run when the `with` statement starts
* The exit method executes the code that will be run when the `with` statement block is complete, `type`, `value`, `traceback` are three sets of information that are set if an exception occurs (exceptions have a type, may have a value,  and a traceback)

This code will be run automatically when we use `with`:
```python
with MyClass() as cc: #__enter__ is executed
	cc.sayhi()
# __exit__ is executed
```


