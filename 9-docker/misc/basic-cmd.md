# Docker basics

## Table of contents

- [Docker basics](#docker-basics)
  - [Table of contents](#table-of-contents)
- [1 - Basic commands](#1---basic-commands)
  - [1.0 Basic structure](#10-basic-structure)
  - [1.1 Querying info](#11-querying-info)
- [2 - Containers](#2---containers)
  - [2.1 Managing containers](#21-managing-containers)
    - [Start a container](#start-a-container)
    - [Stop a container](#stop-a-container)
    - [Deleting containers](#deleting-containers)
  - [2.2 Monitoring containers](#22-monitoring-containers)
    - [Get the container logs](#get-the-container-logs)
    - [Check processes in a container (top)](#check-processes-in-a-container-top)
    - [Get details of container configuration](#get-details-of-container-configuration)
    - [Get stats](#get-stats)
  - [2.3 Listing containers](#23-listing-containers)
    - [Listing running containers](#listing-running-containers)
    - [Listing all containers](#listing-all-containers)

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

### Start a container

To run a container:

```
$ docker container run <options> <image name>:<tag>
```

* Looks for a local image matching the name insterted, otherwise looks in Dockerhub for it, and then runs it
* Options:
  * `--publish <local port>:<container port>`: binds the traffic from the local host port to the container.
  * `--detach`: runs the container as a daemon.
  * `--name <container name>`: defines the container name (otherwise it is randomly generated)
  * `-p <local port>:<container port>`: binds local and container ports (container is accessible through local port). Many options can be specified, such as the IP where the container runs. If no IP address is specified, they will run on `127.0.0.1`.
  * `-e EXAMPLE_ENV_VARIABLE=dummy`: defined an environment variable inside of the container. (Optionally, `--env` can be also used).


> Note: if no `<tag>` is specified, Docker will pull the latest version from Dockerhub

> Note 2: Docker gives each running container a virtual IP inside the docker engine

### Stop a container

Stopping a running container:

```shell
$ docker container stop <container id>
```

* Stops the running container


> Note: as `<container id>`, it is enough to run the digits that make that id unique.

### Deleting containers

```
$ docker container rm <options> <container id(s)>
```

* Deletes the container(s) specified
* Options:
  * `-f`: forcefully delete a container (even if it is currently running)

## 2.2 Monitoring containers

### Get the container logs

To get the logs of a container running as daemon:

```
$ docker container logs <container name>
```

* Returns all the logs the container has generated since its start
* Options:
  * `--tail <n>`: outputs the last `n` lines of logs the container registered
  * `-f`: "follows" the log generation (in real time)

### Check processes in a container (top)

It can be useful to look at the different processes running inside a container. It
can be done with the below command:

```
$ docker container top <container name>
```

- Shows the processes running inside a container

### Get details of container configuration

It can be useful to know all the metadata used to start a container:

```shell
$ docker container inspect
```
- Returns a JSON array of all the data used to initialise the container.

### Get stats 

We can check how much resources (CPU, etc) each of the running containers is taking by running the below command:

```shell
$ docker container stats
```

- Shows live data of local resources used by each container (CPU, Memory, Disk...), displayed by ID.

> Note: we can specify a name to only view the stats of a single container instead of all the ones running.

## 2.3 Listing containers

### Listing running containers

```shell
$ docker container ps <options>
```

### Listing all containers

```shell
$ docker container ls <options>
```

* lists all running containers
  * Options:
    * `-a`: lists all containers (stopped, and running)
