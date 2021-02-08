# Clean stuff in Docker

# 1 - Generic cleanup

Check space taken by Docker:

```sh
$ docker system df
```
- Shows all space taken by Docker locally

Clean up everything that is not being used:

```sh
$ docker system prune <options>
```
- Will remove all "dangling" images, containers & networks
- Options:
  - `-a`: remove all unused resources not being used by at least on container
  - `--volumes`: prunes volumes as well

# 2 - Containers
## Stop a running container

Check which processes are running:
```sh
$ docker ps
```

Stop a process:
```sh
$ docker kill <container-name>
```

## Remove non-running containers

Check downloaded containers (not running)
```sh
$ docker container ls -a
```

Delete a container
```shell
docker rm <container-id>
```

# 3 - Images
List all images downloaded:
```shell
docker images
```

Delete an image:
```shell
docker rmi <image-name>
```

Delete all images:
```shell
docker image prune -a
```

# 4 - Others

## Volumes

List volumes:
```shell
docker volume ls
```

Prune volumes:
```shell
docker volume prune
```

## Networks

```shell
$ docker network prune
```
