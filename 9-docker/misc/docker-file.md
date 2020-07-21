# The `Dockerfile`
#docker

# `Dockerfile` basics
The `Dockerfile` defines the set of actions that need to be executed from a “base” image to define the image that will be saved in our local machine and spawned every time we run `docker run <name-img>`

To create an image from a Dockerfile:
```
docker build -t <image-name> .
```
* `-t`  stands for 'tag’, it gives a name to the docker container
* `.` stands for the folder where docker should look for the Dockerfile

# Syntax of the `Dockerfile`
`Dockerfiles`  create "base” images, that will be created step by step once (first time we “build” them), then saved in our local machine (folder?) to be spawned nearly instantly when run the `docker run` command.

## Step 1: parent image
As much as possible, we want to use a parent image that has some functionalities to it (ex: if we want a python environment, it is usually better to download the python container, which is maintained by professionals). We should always **read the documentation of the image** from Dockerhub to see what it has.
Example of “initial image":
```
FROM python:3.7-slim
```
> Note: `python:3.7-slim` is a smaller version of python (with the minimum installed (~200 MB), versus the full `python:3.7` image (~1 GB)  

## Step 2: adding additional packages
After checking what is in the image, we might want to add inital packages (to install things) that might not be on the image such as `sudo`, `git`, `tree`  , `wget`

Example:
```
RUN apt update && apt install -y sudo git tree wget
```
> Note: what is -y  

## Step 3: creating new user
It is good practice to create a user on the container as default, and get root accesses only when required.
(Lear Linux administration)
```
RUN useradd devops -m -s /bin/bash && \
    usermod -aG sudo devops && \
    echo “devops   ALL=(ALL) NOPASSWD:ALL” > /etc/sudoers.d/devops
```

## Step 4: creating a directory
We can create a base folder where we will bind all the working files
```
WORKDIR /workspace
```

## Step 5: install all additional package requirements
It is good practice to keep the additional requirements on a separate file `requirements.txt` (if it is a `.devcontainer`, otherwise that can be changed on the Dockerfile itself)
We can do that by copying `requirements.txt` to the home folder of the container:
```
COPY requirements.txt .
```

Then installing the requirements:
```
RUN pip install -U pip && \
    pip install -r requirements.txt
```

## Step 6: exposing ports
Our local machine might want to get data from the container. If that is the case, we might want it to run in a specific port. We use the following command:
```
EXPOSE 5000
```

## Step 7: become regular user (same we created in step 3)
```
USER devops
```

# Multi-stage builds
We can build a container in multiple steps (if anything has to be compiled). Good security measure to not get all complied packages. We use that in production.






