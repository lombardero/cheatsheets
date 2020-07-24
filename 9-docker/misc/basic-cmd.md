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

# 2 - Containers
## 2.1 Managing containers
### 2.1.1 Start a container
To run a container:
```
$ docker container run <options> <image name>:<tag>
```
* Looks for a local image matching the name insterted, otherwise looks in Dockerhub for it, and then runs it
* Options:
  * `--publish <local port>:<container port>`: binds the traffic from the local host port to the container.
  * `--detach`: runs the container as a daemon.
  * `--name <container name>`: defines the container name (otherwise it is randomly generated)
> Note: if no `<tag>` is specified, Docker will pull the latest version from Dockerhub
> Note 2: Docker gives each running container a virtual IP inside the docker engine

### 2.1.2 Stop a container
Stopping a running container:
```
$ docker container stop <container id>
```
* Stops the running container
> Note: as `<container id>`, it is enough to run the digits that make that id unique.

### 2.1.3 Deleting containers
```
$ docker container rm <options> <container id(s)>
```
* Deletes the container(s) specified
* Options:
  * `-f`: forcefully delete a container (even if it is currently running)

### 2.1.4 Get the container logs
To get the logs of a container running as daemon:
```
$ docker container logs <container name>
```
* Returns all the logs the container has generated since its start
* Options:
  * `--tail <n>`: outputs the last `n` lines of logs the container registered
  * `-f`: "follows" the log generation (in real time)

### 2.1.5 Check processes in a container
It is useful to 
```
$ docker top <container name>
```
- Shows the processes running inside a container

## 2.2 Checking containers
```
$ docker container ls <options>
```
* lists all running containers
  * Options:
    * `-a`: lists all containers (stopped, and running)
