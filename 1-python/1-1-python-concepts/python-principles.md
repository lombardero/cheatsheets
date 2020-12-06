# Python principles

Python is written taking very specific design choices, which follow a permissive philosophy (in contrast of restrictive languages as Java): nothing is truely private in Python (anyone can access any variable). 
This philosophy is illustrated by two concepts: duck typing and "easier to ask forgiveness than permission".

Check the [Python guide coding style](https://python-guide-chinese.readthedocs.io/zh_CN/latest/writing/style.html).

# 1 - Duck typing
Duck typing is the idea that: if a method is defined and works for a specific object, we should not care if that object is not the one the function was intended for. "If it works, let's go with it", or "if it quacks like a duck, it must be a duck". This idea means that it is not very "pythonic" to check if a certain object is of a specific class: rather, we try to use a method for it and see if it works. If it works, great: some additional functionality that might be useful. If not: the user of the code was the one who broke the "contract".

Example of duck typing (both objects have the same method -> they can be called by the same functions):
```python
class Duck:
    def quack(self):
        print("Quack!")

class Person:
    def quack(self):
        print("I can also quack!")
```

# 2 - EAFP
"Easier to ask forgiveness than permission" means that the "pythonic" way of doing things is trying to run the code, and then handle that error if it fails.

This idea builds on top of duck typing. For a specific object to work in a piece of code, it needs to have the methods required (not being the object intended). The "pythonic" way of handling any issues is not checking that the objects can be executed by the code at each step, but rather executing it with a `try:`-`except:`.

"Pythonic" way of handling method calls:
```python
def execute_quack(thing):
    try:
        thing.quack()
    except AttributeError as err_msg:
        print(err_msg)
```
- Will print `'<object name> has no attribute 'quack'` for any object passed without the method defined.

"Pythonic" way of parsing a dictionnary:
```python
person = {'name': 'John Galt', 'age': '35'}

try:
    print("I am {name}, I am {age} years old and I live in {address}".format(**person))
except KeyError as err_msg:
    print("Missing {} key".format(err_msg))
```
* Will print `Missing 'address' key`

"Pythonic" way of reading a list:
```python
my_list = [1, 2, 3, 4]

try:
    print(my_list[5])
except IndexError:
    print("Index does not exist.")
```
