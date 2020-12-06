# OOP Principles: 2 Inheritance
Inheritance allows to add functionalities to an already existing project, by building new functionalities on top of preexistent ones.

# 1 - Basic inheritance
Inheritance allows “child” classes to inherit attributes and methods from other “parent” classes.

Example of parent Class:
```python
class Date:
	def get_date(self):
		return '2020-06-03'
```

Example of child Class:
```python
class Time(Date):
	def get_time(self):
		return '20:51:46'
```
* Thanks to inheritance, through passing the `Date` keyword in the Class, we can use the `get_date` method on the `Time` class.

> Note: python will look for attributes (variables and methods) first on the instance, then on the Class, then on the Parent Class.  

# 2 - Inheriting the constructor
If the child class does not have a built-in constructor (`__init__`), Python will look it in all parent classes, and use that one. 
We can also extend the functionalities of the parent constructor using `super()`.

Let’s say we have a parent class:
```python
class Parent:
	def __init__(self, name):
		self.name = name
```

We can now extend the functionalities of the constructor in the child class:
```python
class Child(Parent):
	def __init__(self, name):
		super(Child, self).__init__(name)
		self.rand_attribute = random.choice(['One', 'Two', 'Three'])
```
* This code enables to use the functionalities of the constructor defined in the Parent class, and add some additional code to the Child class.
> `super(Child, self).__init__(name)`: the `super()` function allows us to call the `__init__()` function of the parent class with the instance just created. Super takes the instance of `Child` (called `self`) and passes it into the constructor of the parent class of `Child`, then the new functionality can be called.  
> Note: we could also call `Parent.__init__()` to reuse the code of the Parent class, but that is less maintainable (there might be in-between classes added, or Parent might change of name).  

# 3 - Multiple inheritance
Child classes can inherit from multiple Parent classes. The order in which such classes are added in the Child class creation is important, as in search of a parent method, Python will first look at the first Parent class (and all its ancestors - “depth-first”) to then check the next class.
> Note: this is true as long as the two parent classes do not both inherit from the same “grandparent” class. If they do, Python will inspect first both Parent classes, and then the grandparent one. It is still a “depth-first” search, but Class duplicates (the earlier occurrences) are removed.   

```python
class Child(FirstParent, SecondParent):
	pass
```
* Python will look at `FirstParent`(and all its ancestors first), then `SecondParent`

> Note: we can check a class’ “lookup order” using the `mro()` method: `print(Child.mro())` will print the order of lookup.  

# 4 - Abstract classes
Abstract classes are “base classes” that can be created with Python so that other classes with a consistent structure are created from this base template. They allow us to define “mandatory methods” that all sub-classes will need to have. Abstract classes cannot be instantiated. (For more details, check `abc` module).

Creating an abstract class:
```python
import abc #library allowing abstract classes

class BaseClass:
	__metaclass__ = abc.ABCMeta

	@abc.abstractmethod
	def mandatory_method(self): #can put more inputs
		"""Description"""
		return
```
* The `BaseClass` abstract class will force all of its sub-classes to define a `mandatory_method()` ; an abstract method requires an empty `return` statement
* `__metaclass__` is a magic attribute from a Class, and when we set it up to `abc.ABCMeta`, we avoid anyone from creating a `BaseClass` instance (this Class can only have children).
> Note: Abstract classes can have predefined methods that are not abstract (and all of its children inherit).  

# 5 - Using inheritance
## 5.1 - Extending methods
We can extend the functionalities of parent methods through the `super()` function.

Let’s consider the following parent class:
```python
class ParentClass:
	def __init__(self):
		self.val = 0

	def set_val(self, value):
		self.val = value
```

Now, we can create a Child class implementing a more complex `set_val` method reusing the code of the parent class:
```python
class ChildClass:

	def set_val(self, value):
		if not isinstance(int, value):
			value = 0
		super(ChildClass, self).set_val(value)
```
* `super()` takes the instance of the Child class and applies the code of the Parent class with the specified argument

## 5.2 - Overriding
A Child class can re-define a method on it, in that case, that child implementation will be kept. Remember: given a method name, we first look in the Class, then the Parent.

## 5.3 - Inheriting from Python’s built-in classes
We can create Classes that inherit from any other Class, even the ones defined by Python itself. That will grant us all of the methods defined for that Class, and the possibility of changing/adding functionality to it with a new, custom class.

> Note: when re-implementing some of the magic methods of each object, we need to use the method’s name (the ones with underscores) in the original object, otherwise we might get an infinite loop.  
Example: re-implementing the “set key value pair” in a dictionary.
```python
class ManuDict(dict): #inherits from python's dict
	def __setitem__(self, key, val):
		# we use the magic method in dict to get the same functionality
		# additional code... (validating?)
		dict.__setitem__(self, key, val)
		# additional code...
```

# 6 - Composition, an alternative to inheritance
Composition is the idea of building the functionalities through independent Classes with decoupled functionalities that can work with each other, instead of inheriting from many classes (which can break some code if parent classes are modified).
Composition uses several Classes that are not related bu can work together.

Example: Class that takes in any type of object into it, and calls the `write()` method on it (it assumes it is implemented for all objects used).
```python
class Write:
	def __init__(self, writer):
		self.writer = writer #object to write
	def write(self, msg):
		self.writer.write(msg)
```
* Note that the code assumes that the `write()` method is implemented in the `writer` object (polymorphism).
