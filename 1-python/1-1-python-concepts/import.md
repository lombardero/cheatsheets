# Importing stuff
In python,  we can import modules (module = file containing python code) using different syntaxes.

As an example, we will use a file called `module.py` with the following code:
```python
variable = 10

def dothis()
	print("executing the dothis() function")
```


## 1 - Simple import
We can now make available the code in `module.py` through a simple import:
```python
import module

# We can now access the variable and call the function using the module name:
print module.variable #will print the variable
module.dothis() #will call the function
```

We can also change the name of the module to make it easier to import:
```python
import module as mm

# We can now access the variable and call the function using the new name defined:
print mm.variable #will print the variable
mm.dothis() #will call the function
```

## 2 - Importing the objects
We can directly import the objects defined in the code so that we do not need to mention the name of the package:
```python
from module import variable, dothis

# We can now access the variable and call the function directly:
print variable #will print the variable
dothis() #will call the function
```

Note: imported objects can be Classes
