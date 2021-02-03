# Docker images

This section explains all about Docker images: what are they and how to create them.

> Click here to [go to the commands cheatsheet](#2---image-commands).

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

# 2.1 Inspecting images

### View image history

```sh
$ docker history <image name>
```
- Shows the history of the image: all the changes done from the scratch image (base
  one) to the current status. Each command run is usually one
  [layer](#12-image-layers). 

### Get the image metadata

```sh
$ docker image inspect <image name>
```
- Returns a JSON object with all the metadata the image has (author,
  tags of the image, dates, details on how to run it, env. variables,
  exposed ports, etc.)
