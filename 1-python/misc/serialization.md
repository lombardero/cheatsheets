# Serialization

Serialization means storing a Python object in persistent storage (or transferrable format such as JSON). It can be relational (writing data in tables, ex: SQL) or object-based (ex: MongoDB). Sometimes, ORMs can be the layer that connects both.

# 1 - Pickle
The `pickle`  library allows us to store any kind of Python object (even Class instances and its state) in persistent storage.
> Note: the code that generated the object needs to be available for `pickle` to load it successfully . For example, Class instances require the original definition of the Class to be available to load successfully the Class.  

## 1.1 Storing on a file
Saving data on a file with Pickle:
```python
my_list = ['a', 'b', 'c']

with open('file.txt', 'w') as fh:
	pickle.dump(my_list, fh)
```

Opening the same object:
```python
with open('file.txt', 'w') as fh:
	read_list = pickle.load(fh)
```

> Security note: using `pickle`, we must be sure of the origin of the file, since it could contain (and execute) malicious code.  

## 1.2 Storing class instances
This is the code to load a class instance from a pickle file (inside the class):
```python
with open(filename) as fh:
	loaded_instance = pickle.load(fh)
	self.update(loaded_instance)
```

Saving the Class instance:
```python
with open(filename, 'w') as fh:
	pickle.dump(self, fh)
```
> Note: this will erase and re-write the whole pickle file (file open in `’w'` mode  

## 1.3 Storing on a string
Pickle allows to store any object on a string with the `dumps` method.
```python
#string_var is a string version of the input object
string_var = pickle.dumps(['a','a',1, 'bla'])

# we can get back the original object
var = pickle.loads(string_var)
```

# 2 - JSON
JSON has become one of the most used languages to store and send data for its simplicity and its human-readability.  Stores key-value pairs and looks very similar to a Python dictionary.

> Note: two classic mistakes. First, the last element on the JSON file should not be followed by a comma. And secondly, single quotations are not allowed in JSON format!  

Loading a JSON as a Python dictionary:
```python
import json

with open('file.json') as fh:
	imported_dict = json.load(fh)
```

Storing a dictionary as a JSON file:
```python
import json

with open('file.json', 'w') as fh:
	json.dump(saved_dict, fh)
```
* This will store the JSON file as a hard to read single-line

Storing a dictionary as a good-looking JSON file:
```python
import json

with open('file.json', 'w') as fh:
	json.dump(saved_dict, fh, indent=4, separators=(',', ': '))
```

> Note: the same as with `pickle`, any object can be stored as a JSON object.  

# 3 - YAML
YAML is a language used to store structured data, which is widely used for its great readability (even better than JSON, since no brackets or quote marks are required). YAML is used currently to store the configuration of many libraries and tools.

> Fun fact: YAML stood originally for “Yet Another Markup Language”, but now has been rebranded as “Yaml Ain’t Markup Language” (which is a recursive name) to distinguish its purpose as data-oriented rather than a markup language to document stuff.  

Python can read and write YAML files using the `pyyaml` library (does not come preinstalled with Python), which transforms tuples, lists and dictionaries (even nested ones) into YAML files.

Transforming Python objects in a YAML file:
```python
my_dict= {'a': 1, 'b': 2}

yaml.dump(my_dict, default_flow_style=False)
```

Loading YAML files into Python objects:
```python
with open('file.yaml') as fh:
	read_yaml = yaml.load(fh)
```

> Note: the same as with `pickle`, any object can be stored as a YAML file (the original code needs to be available).  

> Security note: Also the same as `pickle`, we must be sure of the origin of the file, since it could contain malicious code. We can use `yaml.safe_load(fh)` in order to be sure there is no executable code in the YAML file (this method will only load dictionaries and lists, not any type of code).  



