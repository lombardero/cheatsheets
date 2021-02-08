# Best practices in Docker

# 1 - Building Images

### Logging

The best practice when building images is to create a layer that spits out the
container logs into standard output and standard error. We usually do so by
linking the traffic on the default logging folders of the base image (will
depend on the base image) to docker's standard in and out. This removes the 
complexity from having to set up logging from the app itself.

Example of such practice for an `nginx` image:

```Dockerfile
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log
```

### Using official images

As starter images, it is best practice to use the official images for a given
application (ex: using the `python` image for python), they are easier to
maintain.

> Tip: check the official images' documentation, they usually come with really good
> defaults.

### Giving names to volumes

There is no way to tell to which container or images a volume is bound to. Hence, it
is very useful to name volumes when instantiating docker containers. 

For example, we might use the below command to run a `mysql` image:

```sh
$ docker container run -d --name mysql -e MYSQL_ALLOW_EMPTY_PASSWORD=True -v mysql_db:/var/lib/mysql mysql
```
- The `-v <volume name>:<path to volume in container>` will add a name to the given
  volume.
