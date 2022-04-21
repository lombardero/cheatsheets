# Fast API

[Documentation](https://fastapi.tiangolo.com/).

# Main features
FastAPI is a nice middle ground between `asyncio` (adds more features)
and `django` (less restricted).

Also, FastAPI works with any kind of ASGI Server (what is that)?, since
it is only a Framework (wrapper).

Features of `fastapi`: more batteries included
- Supports `async` but also enables synchronous functions
- `openapi` / `swagger` docs generation
- Fast API works with a serv 


## Hello World example

```py
import asyncio
# Import framework.
from fastapi import FastAPI

# Import server.
from hypercorn.asyncio.import serve
from hypercorn.config import Config


app = FastAPI()

@app.get("/")
async def root():
    return{"message": "Hello"}


if __name__ == "__main__":
    # Configure the Hypercorn ASGI server.
    hyper_config = Config()
    hyper_config.bind = "127.0.0.1:8000

    # Serve the application.
    asyncio.run(serve(app, hyper_config))
```
- This code runs a "hello world" service, which has a swagger page built on-the-spot
  on the `<base url>/docs#` page.

## Returning something

```py
@app.get("/some-resource/{resource_id}", response_model=dict[str, int]) # This will affect what is returned
async def get_value(resource_id: int): -> dict[str, int] # This is just a type hint
    """Return an integer."""
    return {"message": resource_id}
```
- The `response_model` will affect what is actually returned; types are casted to the
  `response_model` type specified.
- Anything added between brackets will be captured by FastApi and passed as an argument
  of the function.


## Add validation of the path variables

```py
@app.get("/some-resource/{resource_id}", response_model=dict[str, int]) # This will affect what is returned
async def get_value(
    resource_id: int = Path(..., description="This value does this.", ge=5),
    ): -> dict[str, int] # This is just a type hint
    """Return an integer."""
    return {"message": resource_id}
```
- `description`: is added as a description in the swagger page.
- `ge`: validation of the variable: should be greater or equal than. This will send back
  an error to the user if the value does not match.
Can you pass a parseable JSON as response model?

## Adding query parameters

```py
@app.get("/some-resource", response_model=dict[str, int]) # This will affect what is returned
async def get_value(
    parameter: int = 0
    ): -> dict[str, int] # This is just a type hint
    """Return an integer."""
    return {"message": parameter}
```
- This will enable using a query parameter `<base URL>/some-resource?parameter=X`


# Post model

## Integration with `pydantic`

It enforces type hints at runtime. Enables to work with dataclass-like model which
can be enforced. See [this example](https://fastapi.tiangolo.com/tutorial/response-model/).

> See [pedantic models](https://pydantic-docs.helpmanual.io/usage/models/).


```py
from pydantic import BaseModel

class User(BaseModel):

    name: str
    age: int

class UserWithId(User):

user_id: int


@app.get("/some-resource", response_model=UserWithId, status_code=HTTPStatus.CREATED) # This will affect what is returned
async def return_value(
    user: User
    ): -> dict[str, Any] # This is just a type hint
    """Return an integer."""
    user_id = rand(1, 100)

    return { blabla }
```

- Note: check out `Request` and `Depends` objects from the FastAPI.
