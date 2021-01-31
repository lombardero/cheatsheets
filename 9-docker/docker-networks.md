# Docker networks

# 1 - Basic concepts

## What are networks used for in docker

Networks are abstractions that allow traffic between containers. The best
way of connecting two containers is to put them in the same network; once
that is done, both containers can talk to each other and will live in a
"containerized" network.

That way, two containers will be able to talk to each other if they expose
their ports, AND are in the same network.

> Note: Docker has a "Batteries included, but removable" philosophy, where
> defaults work, but are customizeable. (everything works without specifying
> a network)

## How networks interact with the host IP

By default, all containers are connected to a network called "bridge" (also called
"docker0"), which is used by Docker to connect to the host machine's Ethernet interface
(so the traffic can reach the host -> otherwise it would be rejected).

When we add the option `docker container run -p 8080:80`, we are telling docker to
forward any traffic incoming from the port 8080 of the Ethernet interface to port
80 of container.

## Networks vs exposing ports

All containers run through a NAT firewall (a process blocking all traffic the
private IP did not request) on the host IP. When we use `docker container run -p`,
we are exposing the container traffic to a port in the host system. 

> Note: two containers cannot be exposed on the same port at the Host.

Two applications do not need to have their ports exposed to talk to each other
(ex: a process connected to a MySQL database), the best practice is to put them in
the same network (which will be isolated).

> Note: containers can talk to multiple networks.

We should put containers that talk to each other in the same networks, so the traffic
does not need to go out to the Ethernet interface and back in.

## Different networks in Docker

There are three special networks in docker (apart from the ones the user creates):
- `bridge` or `docker0`: the default network all containers are attached to
- `host`: a network that skips the usual networking of Docker and connects the
  containers directly to the host interface (containers are less protected but
  enhances performance in certain situations)
- `none`: a network that is not attached to anything

## Default security

By default, containers are never exposed to the host, their traffic is only connected
via the docker networks. If a Docker must be accessed from the outside, it must be
exposed explicitely with `-p`.


# 2  - Getting data

## 2.1 Show open ports

Use the below command to show the open ports of a specific container:

```sh
$ docker container port <container name>
```

- Shows which containers are forwarding its trafic from the host to the
  container.

## 2.2 Get container IP address

```sh
$ docker container inspect --format '{{ .NetworkSettings.IPAddress }}' <container name>
```

- Returns the IP address of the container.

> Note: `--format` can be used for get many other data from the container. The field
> between brackets is used to filter out one of the JSON fields

# 3 - Interacting with networks

## 3.1 Querying networks

```sh
$ docker network ls
```
- Lists all available networks

```sh
$ docker network inspect <network-name>
```
- Prints a JSON object with all the details of the network, including which containers
  are attached to it.

## 3.2 Creating networks

```sh
$ docker network create <network-name>
```
- Creates a new network
- Options
  - `-d`: specify the driver (?), by default will use `bridge`
  - 

## 3.3 Connecting containers to networks

```sh
$ docker network connect <container name> <network name>
```
- Connects the container to the network specified (attached the container to a new
  ethernet interfaces - different networks have different IP addresses)
