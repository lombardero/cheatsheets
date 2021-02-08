# Docker images

This section explains all about Docker images: what are they and how to create them.

> Click here to [go to the commands directly](#2---image-commands).

Contents:
1. [Basic concepts](#1---basic-conceps)
2. [Image commands](#2---image-commands)
3. [Building images with the `Dockerfile`](#3---building-images)
4. [Uploading to Dockerhub](#4---uploading-to-dockerhub)


# 1 - Basic conceps

## 1.2 Intuition on images

Using technical jargon, a Docker image is "an ordered colection of root filesystem
changes and the corresponding execution parameters for use within a container runtime".

More intuitively, an image consists of the minimal data required to run a piece of
code starting at a given point in time. Images are created by taking a snapshot of
a piece of software, saving it, copying it, and running instances of the copies.
The snapshot is the image, and the copies are the containers.

Docker images consist of all the app binaries of the software we intend to run,
all their dependencies, and metadata about the image's data and how to run it.

Inside an image there is no OS, not even a kernel or kernel modules (e. g. drivers).
The host provides the kernel. This allows for docker images to be really small. 

> Note: the "host" is not the local machine. Docker actually runs a Linux VM on which
> all containers are run.

## 1.2 Image layers

### What are layers

Images are not huge chunks of data coming from a big blob. They are designed using
the union filesystem concept of making layers about the changes. These are visible
when running `docker history <image name>`, where all the layers of the image are
displayed.

The image always starts from a base image we call "scratch"; all the changes added
to that base image is an additional layer (i. e. running a command, adding environment
variables). Each layer of the image is identified with a unique hash, which enables
other images to use that same layer (the stored version of it) if shared. This saves
a lot of space and booting time.

This works also for custom-made containers. If we create two images with `Dockerfile`s
that only copy application A or B in the container, the common layers from both images]can be shared (hence saving a lot of space).

### Containers are also layers

Containers are "runtime" changes that are stacked on top of the base image. Unlike
images (which are read-only layers), containers can be modified at runtime. When a
container runs, it actually adds a new "running instance" of changes that is stacked
on top of the base image. That means that two running containers on the same image
actually share that layer stack.

> Note: if one of the containers changes one of the files that were originally on the
> base image, what happens is that these files are copied onto the container, adding
> an additional layer of changes on top of them. This is known as "copy on write".

## 1.3 Docker hub

Docker hub is the online registry of Docker images. Official ones and the ones made by
users.

Official images do not have an `<username>/<image name>` format, they simply show the
image name. Official images are maintained tested and documented (usually really well)
by professionals (much stable). However, some popular private images might add useful
things.

Usual tags of images:
- `<image name>:latest`: latest stable version of the image (default)
- `<image name>:stable`: stable version, this version is older than the latest, but also
  will be used through a long time and will almost certainly not contain any bug.
- `<image name>:<version name>`: fixed version. Specifying any of the digits will pin
  those digits and select the newest one of that version.
- images containing the `alpine` keyword: `alpine` being a micro version of linux, it
  means the image comes from it (meaning it will probably be very small).

> Note: more on Linux distributions in [this section](linux-distr.md).

# 2 - Image commands

## 2.1 Inspecting images

#### View image history

```sh
$ docker history <image name>
```
- Shows the history of the image: all the changes done from the scratch image (base
  one) to the current status. Each command run is usually one
  [layer](#12-image-layers). 

#### Get the image metadata

```sh
$ docker image inspect <image name>
```
- Returns a JSON object with all the metadata the image has (author,
  tags of the image, dates, details on how to run it, env. variables,
  exposed ports, etc.)

## 2.2 Running images

### Download an image

To download an image from Dockerhub:
```sh
$ docker pull <image name>
```

# 3 - Building images

Check the [official documentation](https://docs.docker.com/engine/reference/builder/)
on building Docker images.

The `Dockerfile` is the list of commands used to create an image. It uses a language
that is made similar to bash commands on purpose.

Each statement block (starting with a capitalized keyword such as `FROM`, `ENV`, etc.)
added to the `Dockerfile` is actually a new layer added to the Docker image. When the
image is built, each layer is saved and a hash is given to it. If any other image uses
the same layer, Docker will re-use that layer (speeding up the process immansely).

> Note: the moment a line in the `Dockerfile` changes, all superior layers will
> also change. Docker will however recognise the below layers are the same and
> use the cached ones instead of building. For this reason, we keep the things
> that change the least on the top of the `Dockerfile`.

## 3.1 Building blocks of the `Dockerfile`

`Dockerfile` instructions covered:
- [`FROM`](#from-starting-a-build-stage): base image
- [`ENV`](#env-defining-environment-variables): environment variables
- [`RUN`](#run-running-commands-inside-of-the-image): execute commands
- [`EXPOSE`](#expose-command): ports
- [`CMD`](#cmd-command-to-be-run-at-startup): startup command (required)
- [`ARG`](): arguments
- [`COPY`](#copy-copy-files-into-the-image): copy files into the image
- [`WORKDIR`](#workdir-change-directory): change directory
- [`VOLUME`](#volume-specify-the-container-volume-path)

### `FROM`: starting a build stage

The `FROM` is the main "build" statement in Docker. It indicates from
which base image (usually a basic linux distribution, or the official starter package
for a given application - `nginx`, `python`, etc. - easeri to maintain) a build stage
should start to generate an image. From then on, we will add things
to it.

> Note: images can be built using more than one build stage.

> Note 2: only an `ARG` block can be placed before the first `FROM` statement of the
> `Dockerfile`.
#### Basic usage: one build stage

The `Dockerfile` always starts with a `FROM` statement, that is the base image (usually
a basic linux distribution) from which we will start adding things.

```Dockerfile
FROM <image>:<tag>
```
- Uses the given image as a foundation for the new image being built. Check the
  [linux distributions](linux-distr.md).

#### Using more than one build stage

An image can be created by starting with a basic linux distribution, download all
needed elements to run the application, then storing that as an image. But
sometimes, some credentials we do not want stored in the final image are required
to install certain packages, and some packages are only added to install some of the requirements of the application. They are also not required in the final image.

To sort these two problems, we can two a build stages:
- In the first one, we create a "dummy" initial image, on which we will download and
  install all the required packages to run the application
- In the second one, we start from another blank image, on which we copy the binaries
  or the needed files to run the application.

```Dockerfile
FROM <image>:<tag> as builder

# some other statements

FROM alpine

COPY --from=builder <builder folder> <final image folder>
```

Let's see an example using build stages to build a Python application using `pipenv`:

```Dockerfile
# First building stage
FROM python as builder

COPY Pipfile Pipfile.lock ./
RUN pipenv sync

# Second building stage
FROM python:alpine

COPY --from=builder ~/.venv .venv
COPY --from=builder ~/Pipfile ~/Pipfile.lock ./
```

### `ENV`: defining environment variables

```Dockerfile
ENV VARIABLE_NAME <value>
```
- Adds the given environment variable to image (safe way of storing secrets)

> Note: all environment variables defined in a build stage will be made
> available to the final image. To avoid that, we can unse `ARG` instead.

### `RUN`: running commands inside of the image

We usually use this command to download packages and install things in the image. We
should use the commands that are supported by our base image.

```Dockerfile
RUN <command 1> \
    && <command 2> \
    && <command 3>
```
- Adds a layer to the image running all the specified commands

### `EXPOSE` command

Open the ports in the container on the virtual network so the container is reachable
from the host machine (we still will need to wire the host port to the container with
the `-p <container port>:<host port>`).

```Dockerfile
EXPOSE <open port> <open port>
```
- Ports open in the container (the rest will be closed).

### `CMD`: command to be run at startup

This is a mandatory statement, and is what will start up the container layer. This is
enables us to define the command that will be run every time a container is run from
an image, and every time it is restarted.

```Dockerfile
CMD ["command", "to", "run", "at", "startup"]
```

### `COPY`: copy files into the image

```Dockerfile
COPY <source path> <destination path in the image>
```
- Copies the contents of a file or folder from the host to the image (usually used
  to copy the source code of the application into the image).
- Options:
  - `--chown=<user>:<group>`: sets up permissions for the copied file in the image
    (this works only on Linux-based images)

### `ARG`: use arguments

Arguments are variables that we can pass on to the `Dockerfile` to build the image
(wither through the `docker image build` command, or through `docker-compose.yml`).

There are two ways of using `ARG`: inside or outside of a building stage.

Arguments are defined with the below syntax:

```Dockerfile
ARG ARGUMENT_NAME=<default value>
```

### `VOLUME`: specify the container volume path

All the files the container will put in a given folder will outlive the container and
be stored as a volume locally.



#### Outside of a building stage (before the first `FROM` statement)

The argument will be made available to all building stages, which can access it
to run a command or set an environment variable with `$ARGUMENT_NAME`.


#### Inside of a building stage (after a `FROM` statement)

When `ARG` is used in a building stage, it will define an environment variable with
the argument name and its value, but not persist that environment variable to the
final images (good to avoid storing secrets in final image).

### `WORKDIR`: change directory

This command enables to change the current directory while running commands to
create an image. This could be achieved with `RUN cd <path>`, but it is considered
better practice doing it with `WORKDIR`

```Dockerfile
WORKDIR <path/to/working/directory>
```

## 3.2 Build an image using a dockerfile

Running the `docker build` command will run each of the statements specified in the
`Dockerfile` through the Docker engine, and save them in our local machine as layers
of the image.

```sh
$ docker image build <options> <dockerfile path>
```
- Builds an image using the `Dockerfile` in the current folder
- Options:
  - `-t <image name>:<tagname>`:
  - `-f <dockerfile filename>`: use a custom-named `Dockerfilez


# 4 - Uploading to Dockerhub

## 4.1 Logging in to Dockerhub


```sh
$ docker login
```
- Login and save an authentication key locally

> Note: when this command is run, it will download a session authentication key and
> save it locally. Run this command only if the machine is trusted

```sh
$ docker logout
```
- Logout and invalidate the authentication key downloaded


## 4.2 Tagging

Images do not really have names. The "name" of the image is actually composed by three
pieces of information `<username>/<repository>:<tag>`. In the case of official images,
there is only a repository name: `<repository>:<tag>`.

### Changing the name of an image

```sh
$ docker image tag <original image name>:<tag> <new name>:<tag>
```
- Adds locally a new tag for a given image. The new name given will come after our
  repository name, and that can be uploaded to dockerhub.

> Note 1: this image can now be pushed to dockerhub using `docker image push` (that
> would make a copy of the original image in our repository)

> Note 2: if no tag is specified, `latest` will be used


## 4.3 Interacting with Dockerhub

### Download an image

To download an image from Dockerhub:
```sh
$ docker pull <repository>:<tag>
```

### Push an image

To push an image to Dockerhub:
```sh
$ docker image push <image name>:<tag>
```
