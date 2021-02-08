# Running containers

> Click here to [go to the commands directly](#1---basic-commands).
## Table of contents

- [Running containers](#running-containers)
  - [Table of contents](#table-of-contents)
- [1 - Basic commands](#1---basic-commands)
  - [1.0 Basic structure](#10-basic-structure)
  - [1.1 Querying info](#11-querying-info)
- [2 - Containers](#2---containers)
  - [2.1 Launching and stopping containers](#21-launching-and-stopping-containers)
    - [Run a container from an image](#run-a-container-from-an-image)
    - [Run a command inside of the container](#run-a-command-inside-of-the-container)
    - [Start an already created container](#start-an-already-created-container)
    - [Stop a container](#stop-a-container)
    - [Deleting containers](#deleting-containers)
  - [2.2 Messing with running containers](#22-messing-with-running-containers)
    - [2.2.1 Getting info](#221-getting-info)
      - [Get the container logs](#get-the-container-logs)
      - [Check processes in a container (top)](#check-processes-in-a-container-top)
      - [Get details of container configuration](#get-details-of-container-configuration)
      - [Get stats](#get-stats)
    - [2.2.2 Modifying running containers](#222-modifying-running-containers)
      - [Getting a shell inside the container](#getting-a-shell-inside-the-container)
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

## 2.1 Launching and stopping containers

### Run a container from an image

To run a container from an image for the first time:

```
$ docker container run <options> <image name>:<tag>
```

* Looks for a local image matching the name insterted, otherwise looks in Dockerhub for it, and then runs it
* Options:
  * `-p <local port>:<container port>` (or alternatively `--publish`): binds local and container ports (container is accessible through local port). Many options can be specified, such as the IP where the container runs. If no IP address is specified, they will run on `127.0.0.1`.
  * `-d` (or alternatively, `--detach`): runs the container as a daemon.
  * `--name <container name>`: defines the container name (otherwise it is randomly generated)
  * `-e EXAMPLE_ENV_VARIABLE=dummy` (or alternatively `--env`): defined an environment variable inside of the container.
  * `-t`: allocates a "pseudo-tty", simulates a pairing between a pair of devices (one giving orders, the other receiving them), similar to SSH. It allows to run a command inside the container (usually used along `-i`, which keeps the session open, allowing for multiple commands to be ran)
  * `-v <volume name>:<path to volume in container>`: allows us to define a name for the given volume
  * `-i`: interactive (used usually alongside `-t`), keeps the session open to receive terminal input.
  * `-t`: Allocates a pseudo-TTY (which simulates a real terminal)
  * `--net <network name>`: connects the container to the specified network
  * `--netw-alias <alias>`: defines a network alias for the container. A robin-like
    routing strategy will be used by Docker when accessing containers using the same
    alias.
  * `--rm`: clean up (erase) the container when it is exited or stopped.

> Note: if no `<tag>` is specified, Docker will pull the latest version from Dockerhub

> Note 2: Docker gives each running container a virtual IP inside the docker engine

### Run a command inside of the container

Running optional commands: apart from `<options>`, the `run` command allows to run
alternative commands inside the container with the below syntax:

```sh
$ docker container run <options> <image name>:<tag> <command>
```
* Will run the container and execute a command inside of it.
* (Optional) commands:
  * `bash`: runs a bash terminal on the container (useful if used along `-it`, to get
  a terminal inside the container).
  * `sh`: runs the default shell of the container (some distributions of linux such as
  Alpine do not have bash to save space).

Alternatvely to `run`, the `start` command can be used to run a stopped container (it must have
been started already with `run`):

### Start an already created container

Instead of taking an image and starting a container from it, this command allows us to
start up a container that was already created.

```sh
$ docker container start <options> <container name>
```
- Will start the stopped container requested
- Options:
  - `-a`: attach STDOUT/STDERR and forward signals (used with `-i` to "enter" the
    container terminal)
  - `-i`: interactive mode

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

## 2.2 Messing with running containers
### 2.2.1 Getting info
#### Get the container logs

To get the logs of a container running as daemon:

```
$ docker container logs <container name>
```

* Returns all the logs the container has generated since its start
* Options:
  * `--tail <n>`: outputs the last `n` lines of logs the container registered
  * `-f`: "follows" the log generation (in real time)

#### Check processes in a container (top)

It can be useful to look at the different processes running inside a container. It
can be done with the below command:

```
$ docker container top <container name>
```

- Shows the processes running inside a container

#### Get details of container configuration

It can be useful to know all the metadata used to start a container:

```shell
$ docker container inspect
```
- Returns a JSON array of all the data used to initialise the container.

#### Get stats 

We can check how much resources (CPU, etc) each of the running containers is taking by running the below command:

```shell
$ docker container stats
```

- Shows live data of local resources used by each container (CPU, Memory, Disk...), displayed by ID.

> Note: we can specify a name to only view the stats of a single container instead of all the ones running.

### 2.2.2 Modifying running containers

#### Getting a shell inside the container

To launch a container and open a CLI interface on it we can use:
```sh
$ docker container run -it <image name> <shell type>
```
- The `-i` option adds an interactive session, and the `-t` enables a pseudo-TTY (chec
  [`docker run` section](#run-a-container)).
- Options:
  - `<shell type>` can be `bash`, `zsh`, etc. or even `ubuntu` (which installs the
    minimal ubuntu package).

Optionally, to access a container that is already running we can use:
```sh
$ docker container exec -it <icontainer name> <shell name>
```
- Again, the `-i` option adds an interactive session, and the `-t` enables a pseudo-TTY
  (check [`docker run` section](#run-a-container)).
- Options:
  - `<shell type>` can be `bash`, `sh`, `zsh`, etc. or even `ubuntu` (which installs the
    minimal ubuntu package).

> Note: the requested shell should be installed in the container for this command to
> succeed.

> Note2: leaving the container after accessing it with `exec` will not stop the container
> as `exec` runs a different process than the root one.

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
