# Docker compose

Docker compose lets us launch multiple Docker containers simultaneously, and let them communicate to each other (very useful to run a service + a database). Everything gets defined in a `docker-compose.yml` file.

# Defining the `services`
In here, we will define all the container names that we want to use; each one will be defined either through a base image or a build.

## Defining the containers
We can define a container by a build context or an image.

### Defining a container from a build context
In this case we will need to add two pieces of information: the context (which folder we want to build from), and the path to the Dockerfile:
```yml
container_name:
  build:
    context: ..
    dockerfile: <path-to>/Dockerfile
```

### Defining a container from an image
In this case we will require simply the name of the image (possibly matching the one in dockerhub if we took it from there)
```yaml
container_name:
  image: <image-name>
```

### Defining the hostname
The hostname is simply the name the container will have (such as “Manuel’s Macbook”). (In a linux system it will be shown as `user@hostname`
```yaml
container_name:
  hostname: <hostname>
```

### Forwarding ports
Port forwarding is important if we want to communicate with components outside the container (such as making our browser display some service running on the container)
```yaml
container_name:
  ports:
    - <local-port>:<container-port>
```
> Note: with this syntax, the traffic from the `local-port`  (ex: 8080) to the `container-port`  (ex:80) will be forwarded.  

### Defining the volumes
By default, Docker cannot write on our local machine. All the data created by the container will be lost once that container goes down. 
Volumes are the way to allow that data to persist in our local machine: they “bind” a local folder to a folder inside of the container, keeping both contents in sync (will copy all the contents of the shared folder from the local file to the container, and vice-versa).
```yaml
container_name:
 volumes:
    - <path-in-local>:<path-in-container>
```
> Note: with this syntax, the contents from the folder in `<path-in-local>`  will be bind to `<path-in-container>` . We can create bindings to single files.  

Example:
```yaml
container_name:
  volumes:
    -  ~/.gitconfig:/home/devops/.gitconfig
    - ..:/workspace
```

### Defining environment variables
If our code needs environment variables to run, we can set them up with:
```yaml
container_name:
  environment:
    - VARIABLE_NAME: <variable_value>
```
Note: sometimes values need quotation marks

### Networks
Networks in docker compose allows containers to find each other (by knowing each other’s IP). Once two containers are in the same network (previously called “link”) so that containers can talk to each other by name.

# Run the application
## Possibility A: on the foreground
```
docker-compose up
```
Do `Ctrl+C` to stop containers

## Possibility B: on the background
```
docker-compose -d up
```
* runs docker-compose application as a daemon (background)

```
docker-compose logs
```
* shows the logs of a docker-compose running on the background.
* use `Ctrl+C` to stop viewing them.

```
docker-compose ps
```
* lists all containers running from docker-compose files

```
docker-compose down
```
* Stops and removes the containers




