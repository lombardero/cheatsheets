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
