# Unit testing

# 1 - The `unittest` library
(Simpler)

# 2 - The `pytest` module
> Note: use the command `py.test` to run all tests (all Python files starting with `test` on the current folder).

## 2.0 - Running `pytest` with the CLI
Running all tests from current folder:
```
$ pytest
```
- Runs all tests defined in files `test_<name>.py`. 
> Note: use `pytest <test name>`  to run a specific test file

Running all tests with code coverage report (needs the `pytest-cov` package):
```
$ pytest --cov-report term-missing --cov=. test/
```
- Outputs the code coverage report
> Note: the package creates a `.coverage` binary file

## 2.1 - Defining basic tests
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

## 2.3 Fixtures
Fixtures are an easier way of doing setup and teardowns (actions that happen at the start and the end of test cases). Instead of defining the setup and teardown actions for all test cases, fixtures allow us to create specific actions for different test cases. We simply define a function, and pass it as an argument of the test case (that way it will be connected to it).

### Setting up with fixtures
Example of setup using fixtures:
```python
@pytest.fixture
def setup_database():
	db = MyDatabase()
	conn = db.connect("server-xyz")
	curs = conn.cursor()
	return curs
```
- This code defines a `setup_database` fixture that can be added as an argument to a test case to perform all the database before the test.

Example of test case using the above fixture:
```python
def test_customer_id(setup_database):
	id = setup_database.execute("SELECT id FROM employee_db WHERE name=Lennon")
	assert id == 909
```
- Uses the code defined above to establish the database connections before the test case and passes the cursor object to the test case (in this example, the cursor object allows us to control the DB).

### Setting up and tearing down with fixtures
We can define teardown actions in a fixture, replacing the `return` statement with `yield` (which will make the code under it available after the test case gets executed)

Modified example using teardown:
```python
@pytest.fixture
def setup_database():
	# Setup code
	db = MyDatabase()
	conn = db.connect("server-xyz")
	curs = conn.cursor()
	yield curs
	# Teardown code
	curs.close()
	conn.close()
```
- Defines a fixture that connects to the database and passes the cursor object to the test case, then, when the test case finishes, it will close the connection with the teardown code.

### Setting up one connection for all the tests
Sometimes, database connections can be expensive, therefore, we might not want to open one connection to the database for each single test case using that fixture. For that, we can make the fixture happen one single time in all module for all test cases using it (that way, one connection will be open for all test cases, then closed after all the test cases using the fixture have completed). This allows to save time of tests.

To enable one single setup and teardown for all test cases using the same fixture, we add `scope="module"` as an argument to the fixture object as shown below:
```python
@pytest.fixture
def setup_fixture(scope="module"):
	# Setup code
	yield "dummy"
	# Teardown code
```
## 2.4 Testing multiple inputs in a test case
Sometimes, to test a functionality, it is useful to try multiple input-output tuples at a time (to avoid having to define one single test case for all). For that, we can use the `@pytest.mark.paramtrize` decorator.
> Note: in `pytest` we can only define one single `assert` statement per test case.

Let's illustrate it with an example aiming to test a function that returns the cube of integers:
```python
@pytest.mark.parametrize(
	"test_input, expected_output",
	[
		(1,1),
		(3,9),
		(-4,-64),
		(5,125)
	]
)
def test_cube_numbers(test_input, expected_output):
	result = tested_function(test_input)
	assert result == expected_output
```
- Tests all inputs and outputs all in the same test (without having to define a single test case for each)



## 2.5 Working with filenames
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



