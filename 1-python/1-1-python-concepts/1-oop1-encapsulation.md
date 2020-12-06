# OOP Principles: 1 Encapsulation

# 1 - The basics: instance attributes
Encapsulation is one of the three pillars of object-oriented programming. This principle states that all interactions with the objects should be done through methods, not setting variables directly.

There are two types of methods: instance methods (also called bounded), and class methods (also called static methods).


## 1.1 Instance methods
Instance methods are the ones who take `self` (the Class instance) as a first argument, and do things with it (modify a value for the instance, etc).
There are two types of instance methods: setter (where variables are modified or allocated) and getter methods (where variables are retrieved). 

Example:
```python
class NewClass:
	def set_a(self, a):
		self.a = a
	def get_a(self):
		return self.a
```

The correct way of setting a is therefore:
```python
myinstance = NewClass()
myinstance.set_a(8)
```
* This ensures a method is used to set the variable `a`, instead of using `myinstance.a = 8` which does not use encapsulation

The same way, the `get_a` method should be used instead of printing `myinstance.a`

## 1.2 Instance variables
There are two types of variables we can define in a Class: class variables (consistent for all instances), and instance variables (unique to each instance).
> Note: if an instance defines a new variable for itself (breaking encapsulation) with the same name as the Class variable, when the variable is requested again, the instance one will be returned. (Recall: Python looks for instance variables first, then Class variables).   

Example: consider the following object
```python
class NewClass:
	variable = 10
	def set_instance_variable(self, var):
		self.instance_variable = var
```
* `variable` is a Class variable, and `instance_variable` belongs to instances (attached to `self`).

> Note: If we now create an instance `instance = NewClass()`, we can access the Class variable using `instance.variable` (will return `10`).  
> However, we can also create an instance variable with the same name with `instance.variable = 3` , and that will not modify the class variable, it will create an instance variable with that same name and the value `3` (if we now access `instance.variable`, we will get `3` since instance variables have preference).  
> Now,  we can delete that instance variable using `del instance.variable`. If we call `instance.variable` again, the statement will return `10` (since there are no instance variables matching that name, the class variable will be returned).  

## 1.3 Class variables
Class variables are useful to store data that we want available (and consistent) for all instances of the class.
* Example: a variable that keeps track of the number of instances created. Every time the constructor is called we increment the counter by one. (See below code)

Example of Class that counts instances:
```python
class NewClass:
	instance_counter = 0
	def __init__(self):
		NewClass.instance_counter += 1 #This modifies the class variable, and the same variable is available for all instances!
```

> Note: use `ClassName.variable` to access a Class variable.  

# 2 - Class methods
Class methods are methods that will not need the instance as an input (they only depend on class data), rather, they will take the Class itself as an input. For that, we will add the `@classmethod` decorator, so that it is the Class itself (and not the instance) that is passed as an input. For clarity, we will use the keyword `cls` instead of `self`.

Example of Class method:
```python
class NewClass:
	instance_counter = 0
	def __init__(self):
		NewClass.instance_counter += 1 

	@classmethod
	def get_count(cls):
		return cls.count
```
* `get_count` is a class method, it can be called using any instance, or the name of the class itself: `instance.get_count()` or `NewClass.get_count()`

# 3 - Static methods
Static methods do not take the instance or the class as inputs, but can be used by the Class to perform some useful tasks. We add the `@staticmethod` decorator in order the make them work.

Example of static method checking valid inputs in the constructor:
```python
class NewClass:
	def __init__(self,val):
		self.val = self.filterint(val)

	@staticmethod
	def filterint(value):
		if not isinstance(value, int):
			return 0
		else:
			return value
```
* The static method is used by the constructor to make sure the input is valid.

# 4 - Enforcing encapsulation
## 4.1 Defining private attributes
Private attributes are defined with the classic `regular_syntax`, however, if we intend to define arguments that are private, we will use this other syntax:
	* `_single_underscore` for private attributes (only to be used  inside the instance).
	* `__double_underscore` for private attributes that should not be subclassed.
> Note: Python will not enforce privacy (attributes with underscores will still be accessible).  
## 4.2 Using decorators
Python’s philosophy is to rely on the cooperation from the user to  use the proper methods to define variables, rather than set them by itself. However, there is a way of enforcing control over specific variable names: the `@property` , `@var_name.setter`,  `@var_name.deleter`. These three decorators allow us to define the code to be executed when `var_name` is printed, created, modified or deleted.

Example:
```python
class NewClass:

	def __init__(self, value):
		self.attribute = value
	
	@property #defines the behavior when accessed (get)
	def var_name(self, value):
		self.attribute = value
	
	@var_name.setter #behavior when modified
	def var_name(self, value):
		self.attribute = value

	@var_name.deleter #behavior when modified
	def var_name(self):
			self.attribute = None
```
* Now, we can create an instance of `NewClass`: `a=NewClass(1)`, and when we `print(a)` the code in `@property` will be executed, when we set `a=10`, the code in `@var_name.setter` will be executed, etc.

