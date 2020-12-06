# Python OOP Mechanics

# 1 - The very basics
Everything is an object in python :`list`, `bool`, `NoneType`, `function`, `int`, `str`, `type`…

An object is a unit of data of a particular Class (also called type), with associated functionality.

```
dir(variable)
```
* Will return the attributes of the variable (private or magic ones, used internally by Python, and non-hidden ones).  `variable.attribute` will return some information about the object.

# 2 - Magic attributes
Many Base Classes in python (such as Integers, Strings, etc.), have “magic” attributes defined so that they can be used with certain operators, and called implicitly. These magic methods can be used in the classes we define so we can use the `+` sign with them, and the `print()` statement.

For example: the `__add__` method is called implicitly when we add two integers:
```python
a = 34
b = 12

#this:
c = a + b
#is the same as this:
c = a.__add__(b)
```

The same goes with the `__repr__` method, which is called implicitly when the `print()` function is called (which should return a string representation of the object).

Useful magic attributes:
	* `’abc’ in var`  is actually `var.__contains__(‘abc’)`
	* `var == 'abc'`  is actually `var.__eq__(‘abc’)`
	* `var[1]`  is actually `var.__getitem__(1)`
	* `len(var)`  is actually `var.__len__()`
	* `print(var)`  is actually `var.__repr__()`
