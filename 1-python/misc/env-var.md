# Environment variables
Python code to check if it is not set, and "fail" if no env variable:
```python
DATABASE_URI = os.getenv(“DATABASE_URI”)
if not DATABASE_URI:
    logger.critical(“No DATABASE_URI set. Cannot continue!”)
    sys.exit(4)
```

## Keeping env variables in a separate file
We can use the `dotenv()` library to store variables in a `.env` file and then import them onto the application. Check out [dotenv](https://pypi.org/project/python-dotenv/)
Example of `.env` file defining 3 variables:
```
PORT=5000
DATABASE_URI="postgres://postgres:postgres@localhost:5432/postgres"
FLASK_APP=service:app
```

Loading that environment on the code
```python
from dotenv import load_dotenv
load_dotenv()
```

> Note: we NEVER check the `.env` file into GitHub so our secrets are never compromised.  


Check out: [Persistent Virtualenv Environment Variables with python-dotenv - PyBites](https://pybit.es/persistent-environment-variables.html)