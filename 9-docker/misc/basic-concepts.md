# Docker basic concepts

# What is a container?
A container is a running isolated process. In a Mac, Docker runs a mini Linux VM (Docker is a native Linux process) in which several isolated processes run. Each of these processes is a container. For more details, check [this talk](https://www.youtube.com/watch?v=sK5i-N34im8&feature=youtu.be&list=PLBmVKD7o3L8v7Kl_XXh3KaJl9Qw2lyuFl).
> Note: in this context, "isolated" means they cannot see each other or its files (only if specified).
