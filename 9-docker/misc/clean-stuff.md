# Clean stuff in Docker

# Running containers
Check which processes are running:
```
docker ps
```

Stop a process:
```
docker kill <container-name>
```

# Non running containers
Check downloaded containers (not running)
```
docker container ls -a
```

Delete a container
```
docker rm <container-id>
```

# Downloaded images
List all images downloaded:
```
docker images
```

Delete an image:
```
docker rmi <image-name>
```

Delete all images:
```
docker image prune -a
```