# Docker compose

Docker compos enables to run multiple-container applications (the usual case) with
one command. For that, docker compose introduces two things:
- the `docker-compose.yml` configuration file, in which all the `container run` 
  options are specified (base images, environment variables, volumes, networks,
  etc.)
- a CLI tool that enables to run all these containers with a single command.
  This is very useful for local development or test automation.
  
> Note: check out Docker compose's [official documentation](https://docs.docker.com/compose/compose-file/compose-file-v3/)

# 1 - The Compose YAML file

The compose YAML file contains all instructions that Docker needs to run in order to
build and run a multi-container application.

## 1.1 Version

The Compose file format has its own versions (ex: 3.1, 3.3), which needs to be
specified at the start of the file :

```yml
version: '3.3'
```
- Sets up the version used for Docker compose (default is 1)

## 1.2 Services

The services section on the Docker compose enables us to define all the containers
the application needs to run.

This is the basic structure for defining services:
```yml
services:
    <service name>: # Name Given to the container; this will be used as a DNS for
                    # the container inside the network.
        image: <image name> # (Optional) Same as the "FROM" statement in the Dockerfile
                            # if no base image provided, docker-compose will look for a
                            # Dockerfile path.
        command: ["a", "startup", "command"] # (Optional) Only needed if no Dockerfile
                                             # is provided
        environment:
            ENV_VARIABLE: <value> # (Optional) Sets up an environment variable
        volumes: # (Optional) Define volumes
            - <volume name>:/path/inside/container
        ports: # (Optional Ports exposed)
            - <local port>:<container port>
```

### Starting the container

A container needs either a `Dockerfile` path:
```yml
services:
    <service name>:
        build:
            context: path/to/dockerfile
            args: # (Optional) Arguments passed to the Dockerfile
                - ARG_NAME=<value>

```

Or a base image and a startup command:
```yml
services:
    <service name>: # Name Given to the container; this will be used as a DNS for
                    # the container inside the network.
        image: <image name> # (Optional) Same as the "FROM" statement in the Dockerfile
                            # if no base image provided, docker-compose will look for a
                            # Dockerfile path.
        command: ["a", "startup", "command"] # (Optional) Only needed if no Dockerfile
                                             # is provided
```

### Adding container dependencies

It is common that a given containerized application depends on a second one to run
successfully (ex: an application needs a database to start). We can make Docker compose
start up a set of dependent containers when the "parent" one starts:

```yml
services:
    <service-name>:
        depends_on:
            - <depending-container-name>
```
- Will automatically start up `<depending-container-name>` when `<service-name>` is started
  

## 1.3 Volumes

This section allows us to define all volumes needing to be defined for the application
to run.

## 1.4 Networks

This section will let us set up the networks.

# 2 - Running Compose through the CLI

The Docker compose command is a separate binary file from the regular `docker` one.
On Mac it comes with Docker itself (not on Linux). It is tdesigned for local development
and testing. Docker compose is built thinking it will be used by Docker users, hence,
most Docker commands have their "equivalent" in Compose.

To ge the full list of commands supported:
```sh
$ docker-compose --help
```

## 2.1 Start up the containers

The `up` command sets up the networks, volumes needed and starts running the specified
containers

```sh
$ docker-compose up <options> <container-name>
```
- Setup volumes, networks and runs containers
- Options:
  - `-d`: run all containers in a daemon thread

## 2.2 Stop containers and clean up

The `down` command stops and deletes all containers, volumes and networks created (not
the images though).

```sh
$ docker-compose down <options> <container-name>
```
- Stop and remove all containers, volumes and networks

## 2.3 Getting container data

### Getting container logs

```sh
$ docker-compose <options> <container-name> logs
```
- Print logs of a given container (if no container provided, all logs will de dumped)
- Options:
  - `--follow`: follows the logs instead of just showing the latest ones
  - `--tail=n`: show n latest logs
  - `--no-color`: get logs without color encoding (useful if we capture them for another
    process).

### Showing running stuff

To show running containers
```sh
$ docker-compose ps
```
- Prints the containers currently running from the docker-compose context

To show all services running inside of the containers:
```sh
$ docker-compose top <container name>
```
