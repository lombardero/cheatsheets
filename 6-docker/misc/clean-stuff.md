# Clean stuff in Docker

# Running containers
Check which processes are running:
```shell
docker ps
```

Stop a process:
```shell
docker kill <container-name>
```

# Non running containers
Check downloaded containers (not running)
```shell
docker container ls -a
```

Delete a container
```shell
docker rm <container-id>
```

# Downloaded images
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

# Prune volumes

List volumes:
```shell
docker volume ls
```

Prune volumes:
```shell
docker volume prune
```
