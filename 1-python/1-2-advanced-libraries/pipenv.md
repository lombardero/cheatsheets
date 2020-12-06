# Pipenv commands

`pipenv` is a Python virtual environment manager. Similarly to `npm` for JavaScript,
it uses a base file to list the Python version and packages used on the virtual
environment (these files can be found in `~/.local/share/virtualenvs/<name>`).

`pipenv` automatically uses folders to define projects. To create a virtual
environment for a folder, we simply go to the folder and start installing packages
with `pipenv` (it will automatically check if there is a venv created for that specific
folder, and create it if there is not).

# 0 - Installation

## Mac installation
(dependency: install [Homebrew](https://brew.sh/))

```
$ brew install pipenv
```

## Windows installation

(to be done)

# 1 - Basic operations

## 1.1 Installing the dependencies

To install all dependencies listed on the `Pipfile`, run:
```sh
$ pipenv install
```

> Note: `pipenv install` also generates `Pipfile.lock` file, which "locks" specific
> versions of packages that matchm the requirements. This file is used in Picnic by
> most applications to download dependencies in production.

To install all regular and dev dependencies listed on the `Pipfile`, run:
```sh
$ pipenv install --dev
```

## 1.2 Activating the environment

Once dependencies are installed, the environment can be started by running:
```sh
$ pipenv shell
```
- Searches for an availeble `Pipfile` on the current directory, if it founds one, it
  installs (if not done already) the dependencies and 'enters' the virtual environment
  with the packages listed on the `Pipfile`. Python commands can be run in the CLI from
  this point on.

> Note: if no `Pipflie` is found, `pipenv` will create a new "blank" one

Alternatively, to run specific commands, this command can be used:
```sh
$ pipenv run <command>
```
- Runs a command inside the virtual environment (useful for testing, ex:
`pipenv run pytest tests/`)

## 1.3 Adding packages to the virtual environment

Packages can be added to the virtual environment either by adding them to the `Pipfile`
then running `pipenv install` or through the CLI.

To add a specific package (ex: pandas) through the CLI, run:

```sh
$ pipenv install <new package>
```
- Will add the new package (and its dependencies) to the `Pipfile`, and install it. Use
  the `--dev` flag to add a dev package.
 
> Note: dependencies of packages are listed on the `pipfile.lock` file (JSON format),
> with the specific version used. This file is often used in production to ensure the
> packages used work as expected (avoiding package updates to break our code)

## 1.4 Removing packages to the virtual environment

```
$ pipenv uninstall <package>
```
- Removes a package from the `Pipfile`, and uninstalls it.

## 1.5 Deleting the virtual environment

We can delete virtual environments by running:

```sh
$ pipenv --rm
```

## 1.6 - Integrate with IDEs

To get the python executable location for the IDE, run:

```sh
$ pipenv --py
```

For `VS Code`: On the left-bottom corner of VS Code, tap on the python version and copy
the output of the current `pipenv` interpreter.

## 1.7 Visualise dependency tree

To print the dependency tree, run:

```sh
$ pipenv graph
```
  
# 2 - Additional features

## 2.1 Working with `pipfile.lock` 

(Not frequently used)

Creating a `pipfile.lock` to lock the package versions:

```sh
$ pipenv lock
```
- Updates the "lock" file with the exact package versions used so that the build is not affected by new releases.

Installing packages from "lock" file:
```sh
$ pipenv install --ignore-pipfile
```
- Uses the package versions from the `pipfile.lock` file

We can also make a `requirements.txt` file:
```sh
$ pipenv lock -r
```
- Shows all the dependencies of the current virtual environment (in the format they would go in a `requirements.txt` file).


## 2.2 Installing from `requirements.txt` file
```sh
$ pipenv install -r <requirements-path>
```
- adds all packages on the requirements file in the `Pipfile` and `pipfile.lock`.


# 2.3 - Checks

Checking for vulnerable packages:
```sh
$ pipenv check
```
