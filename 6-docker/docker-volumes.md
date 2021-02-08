# Data volumes

Useful resources:
- [Manage data in Docker](https://docs.docker.com/storage/)
- [O'Reilly's post about immutable infrastructure](https://www.oreilly.com/radar/an-introduction-to-immutable-infrastructure/)
- [The 12-factor app](https://12factor.net/)

By design, Docker containers are ephemeral and immutable (just re-deploy, do not
modify). Hence the data stored on containers will not persist. Volumes and Data Mounts
are the way data (such as databases or unique data) is persisted in Dockerized
applications:
- Volumes are the way we configure images to persist data. A volume is simply a
  location inside of a container, in which all data stored will be persisited in
  a location on the host machine (we do not know which yet, usually a default
  location managed by Docker, something such as
  `/var/lib/docker/volumes/<some_hash>/_data` through a mount).
- Bind mounts are the way this data is actually persisted when a container runs. When
  a container having a volume runs, Docker creates a mount that binds the contents of
  the volume in a container to a physical location in the host machine (usually in a
  folder such as `/var/lib/docker/volumes/<some_hash>/_data`). The data modified in
  any of the two locations is modified in the container as well. But bind mounts can
  be defined dynamically for any folder on the host machine.

> Note: on a Mac/Windows, Docker actually runs a Linux VM; hence, the mount path will
> be on that VM, an not reachable through the host OS.

# 1 - Volumes

## Adding volumes to the `Dockerfile`

Volumes are specified in the image configuration (check the [`VOLUME`](docker-images.md#31-building-blocks-of-the-dockerfile)
section of the `Dockerfile` definition).

> Note: a volume will dynamically create a mount automatically on the host from a default
> address managed by Docker.

## Naming volumes

Volumes can be name when a container is initialised:

```sh
$ docker container run -v <volume name>:<path to volume in container> <options> <image name>
```
- Adds a name to the volume.

## Creating volumes (ahead of time) 

Creating volumes ahead of time is useful if we want to add tags or drivers to them
(not sure why we would need any of those).

```sh
$ docker volume create <options> <volume name>
```

## Inspecting volumes

```sh
$ docker volume inspect <volume hash>
```
- Returns the metadata of the volume (will not say which container it is bound to
  though -> we should add names for it through
  `docker container run -v <volume name>:<volume path>`)

# 2 - Bind Mounts

A bind mount is simply a map between a directory in the host system to a directory in a
container (basically two directories pointing to the same files). It does not need a
volume to work, it is created for a container level.

In the mounts world whatever is in the host system always "wins": it overwrites whatever
the contents of the container. When data is erased at runtime on the container, that will
never affect the host data (preserved), instead, a layer of changes will be superposed
(which only affects the container) - this part is to be checked, not sure. Data created
in the host after the container started will also be updated in the container.

## Defining bind mounts

Bind mounts are created by specifying an absolute path (starting with a `/`) instead of a name when running a container:

```sh
$ docker container run -v /absolute/path/in/host:/path/in/container <options> <image>
```
- Creates a mount binding the contents of the host location inside of the container (the
  container will start with the same files as the host at startup, then modify them).

> Note: to bind the current directory to the container, we can do `$(pwd):/path/in/container`
