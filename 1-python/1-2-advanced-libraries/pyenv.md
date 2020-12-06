# Pyenv

`pyenv` is a Python version manager.

# 1 - Setting up

## Mac setup
```
$ brew install pyenv
```

Add to `.bash_profile` or `.zshrc`:
```sh
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Then this towards the end of the file:
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
```
(Restart your shell)

## Windows setup

(To be done)

Congrats, you can now use `pyenv` to download and install Python versions!

# 2 - Useful commands
## 2.1 Downloading versions
```sh
$ pyenv install --list
```
- Shows the list of Python versions available for download

```sh
$ pyenv install <version number>
```
- Installs the version selected

## 2.2 Changing versions
```sh
$ pyenv global <version number>
```
- Activates as global interpreter the version downloaded

```sh
$ pyenv versions
```
- Shows the local versions of python available

```sh
$ pyenv -V
```
- Shows current active version of python
