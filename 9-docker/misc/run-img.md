# Running Docker containers

# Basic concepts
## Image vs containers
An image is the binaries, source code, and files that make up an application, and a container is a running instance of that image. An image is the "template" from which a container is created.

# Run a container
Will look for an image locally, if not available, will look if it exists on Dockerhub, download it, and run it
```
docker run <name>
```
additional fields;
* `docker run -d <name>` : run process as a daemon
* `docker run -p <container-port:local-port name`: forwards port from container to local machine
* `docker run -v <path-in-computer:path-in-docker> name`: creates a volume that links a local file with a file inside docker.
* `docker run --rm <name>:<tag> name`: will run container and when it stops, it will be deleted automatically
* `docker run -e ENV_VARIABLE=“whatever” image-name`: will create an environment variable in the container’s environment
* `docker run --link container-name image-name`: links the spun off container to another running container so that they can talk to each other. (Alternative, we can create a network and add containers to it to allow them to talk to each other)

# Stop an image
```
docker kill <instance_name>
```

# Create networks
```
docker network create -d <type> network-name
```
* `<type>` can be `bridge` or `overlay`


# Docker exec
Executes commands inside of the containers (needs to be running)
```
docker exec -it container-name <shell command>
```
* Runs any command inside a container 

```
docker exec -it container-name sh
```
* Opens a shell inside a docker container.
* Alternatively: we can run `zsh` or `bash` (debugging tool).

# Tagging
```
docker tag <container-id> <container-name>:<tag>
```
* Adds a container name and a tag to the container ID specified.

# Volumes
```
docker volume ls
```
* lists all volumes specified

# Network
```
docker network ls
```
* lists all networks specified
