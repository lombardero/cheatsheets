# Docker basics

# 1 - Basic commands
## 1.0 Basic structure
There are two types of commands in Docker:
* Management commands (new): `docker <command> <sub-command> (options)`
* Original syntax: `docker <command> (options)`
> Note: the original `docker run` (which still works) is replaced by `docker container run`

## 1.1 Querying info
Check current version:
```
$ docker version
```
* Returns the version

Check generic information:
```
$ docker info
```
* Returns current number of containers (running & stopped), and images

