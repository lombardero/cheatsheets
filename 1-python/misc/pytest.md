# Unit testing
#python

# 2 - The `pytest` module
> Note: use the command `py.test` to run all tests (all Python files starting with `test` on the current folder).  
## 2.1 - Basic tests
Similar to `unittest`, but adding some additional features (not sure what they are).

Example of `pytest` test case testing a function that doubles numbers inside the `my_module.py` file:
```python
import my_module

def test_doubleit():
	assert my_module.function(10) == 20

def test_doubleit_type():
	with pytest.raises(TypeError):
		myprogram.doubleit('hello')
```
* Checking for the correct value and for the right error type (the `with`  statement will check that everything inside of it will raise a `TypeError`

## 2.2 Setup and Teardown
Sometimes tests need some actions before the test runs, and after it runs: for example, setting up a test database with some data, and wiping it out after the test. That is what the functions `setup_class()` and `teardown_class():` do.

Defining both functions:
```python

def setup_class(self):
	#actions performed before each test

def teardown_class(self):
	#actions performed after each test
```


## 2.3 Working with filenames
`pytest` works well with the `shutil` module to handle test files (can be used in the setup and teardown phases), here is an example of copying and deleting files (needs the Class argument).
```python
class TestObj:
    source_file = 'config_file.txt'
    test_file = 'tst_file.txt'

    def setup_class(self):
		shutil.copy(TestObj.source_file, TestObj.test_file)

    def teardown_class(self):
        os.remove(TestObj.test_file)

```



