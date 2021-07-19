# Python section

The Python section might be the most chaotic one on this repository, but also the
richest one. It starts basic, in a linear way, and branches out to many diverse
topics.

Here is a summary of the structure.

# 1 - Basic concepts and libraries

## The basics of Object-oriented programming

- [Part 1: Encapsulation](1-1-python-concepts/1-oop1-encapsulation.md)
- [Part 2: Inheritance](1-1-python-concepts/1-oop2-inheritance.md)
- [Part 3: Polymorphism](1-1-python-concepts/1-oop3-polymorphism.md)

Bonus 1: [Object-oriente building blocks in Python](1-1-python-concepts/oop-mechanics.md)

Bonus 2: old [Classes in Python](1-1-python-concepts/1.2-python-classes.md) overview

## Basic Python concepts and libraries

- [Pythonic principles](1-1-python-concepts/python-principles.md) what is the
  "pythonic" way?
- [Importing stuff in Python](1-1-python-concepts/import.md)
- [Logging stuff in Python](1-1-python-concepts/logging.md)
- [Raising exeptions](1-1-python-concepts/exceptions.md)
- [Debugging](1-1-python-concepts/debugging.md)
- [The `with` context in Python](1-1-python-concepts/with-context.md)
- [Serializing and deserializing](1-1-python-concepts/serialization.md)
- [Working with enviroment variables](1-1-python-concepts/env-var.md)

Bonus: random [Python tricks](1-1-python-concepts/python-tricks.md)

# 2 - Not-so-basic libraries

## Virtual environments

- [`pyenv`, the global python environment manager](1-2-advanced-libraries/pyenv.md)
- [`pipenv`, virtual environment manager](1-2-advanced-libraries/pyenv.md)

## Running asynchronous code

- [What are coroutines](1-2-advanced-libraries/1-2-1-async/generators-coroutines.md)
- [The `asyncio` library](1-2-advanced-libraries/1-2-1-async/asyncio.md): running
  Python asynchronously.
- [`simpy`](1-2-advanced-libraries/1-2-1-async/simpy.md): Simulating stuff with Python

## Threading

- [Threading in Python](1-2-advanced-libraries/1-2-2-threading/threading.md)
- [Subrocesses](1-2-advanced-libraries/1-2-2-threading/subprocesses.md)

# 3 - Web servers

- [`aiohttp`: asynchronous server](1-3-web-servers/aiohttp.md)
- [`flask`](1-3-web-servers/0.1-flask/1%20-%20Flask%20basics.ipynb) (jupyter notebook)
- [The `SQLAlchemy` ORM](1-3-web-servers/0.1-flask/sqlalchemy.md)

# 4 - Data science

## Basic data science libraries

- [Numpy](1-4-data-science/2.1-numpy.md)
- [Pandas](1-4-data-science/2.2-pandas.md) (on the process of translating to
  Markdown)
- [Scikit Learn](1-4-data-science/4.1-scikit-learn.txt)

Bonus: [tricks to understand data with Pandas](1-4-data-science/4.0-data-underst.txt)

## Data visualisation

- [Pandas data visualisation](1-4-data-science/2.3-pandas-dat-vis.txt) (still `.txt` file)
- [Matplotlib](1-4-data-science/3.1-matplotlib.txt) (still `.txt` file)
- [Seaborn](1-4-data-science/3.2-seaborn.txt) (still `.txt` file)
- [Plotly & Cufflinks](1-4-data-science/3.3-plotly-cufflinks.txt): interactive plots
  (still `.txt` file)
- [Choropleth](1-4-data-science/3.4-choropleth.txt): geographical plots (still `.txt` file)

## Deep Learning: `pytorch`

- [Pytorch basics](1-4-data-science/1-4-1-pytorch/1-pytorch-basics.txt) (still `.txt` file)
- [Loading datasets](1-4-data-science/1-4-1-pytorch/2-pytorch-load-data.md)
- [Neural Network support in Pytorch](1-4-data-science/1-4-1-pytorch/3-nn-support.txt) (still `.txt` file)
- [Computer Vision transforms](1-4-data-science/1-4-1-pytorch/4-CV-transforms.txt) (still `.txt` file)

# 5 - Other miscellaneous libraries

- [Scraping data](1-5-other-libraries/0.8-finance/0-scraping-data.md)

# 6 - Testing libraries

- [Unit testing in Python](1-6-testing/unit-tst.md)
