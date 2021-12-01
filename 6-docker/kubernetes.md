# Kubernetes

Kubernetes is an Ochestration system to deploy containerized applications in different servers.

`kubectrl` is the official CLI from Kubernetes. [Go to the commands](#2---the-kubectl-cli).

# 1 - Terminology

- Kubernetes container abstractions: 
  - Pod: basic unit of deployment. A pod is a single or multi-container deployment unit that can be deployed on its own (could be, for example, a service and its DB)
  - Controller: required to create and update pods and other objects. A controller makes sure that what is happening is what we asked kubernetes to do (`Deployment`, `ReplicaSet`, `StatefulSet`, `DaemonSet`, `Job`, `CronJob`, etc.)
  - Service: in Kubernetes, the Service is the network endpoint (consistent) given a Pod to connect to it
  - Namespace: filter to see different pods (nothing more), not the same as Docker. Useful to regulate the `kubectl` pods displayed.
- Node (or worker): single server in the Kubernetes cluster; runs your service
- Kubelet: Kubernetes agent running on nodes so that they can interact with kubernetes (it talks to the "master")
- Control Plane: also referred as the "master", it is the set of containers that manage the cluster. It is a set of containers since it does several functions (linux principle of: do one thing and do it well).

### Containers running on each server
In the Master nodes (Control Plane), we need these containers:
  - API server: the way we talk to the master
  - Scheduler: controls how and when our workers get deployed
  - Controller manager: takes the orders from the API server and applies them
  - Etcd (DB backend): distributed storage system to store configuration data
  - Core DNS: controls the DNS

In the Worker nodes, we will need:
- Kubelet: receives orders from master nodes
- Kube-proxy: control networking

# 2 - The `kubectl` CLI

## 2.1 Display information

### 2.1.1 Pods

#### Visualize available pods

```sh
$ kubectl get pods
```
- List all pods currently running and reachable
- Options:
  - `--namespace=<bla>`: specify the namespace to excute the command for (will use
  - the default namespace)

#### Get details on a specific pod

```sh
$ kubectl describe pod <podname> --namespace=<bla>
```
- Lists all containers in that pod and their status

> Note: the `Image` field on each container is the image tag on docker hub, its format is
> ```
> <organization>/<repository>:<id>.<commit hash>
> ```

#### See logs of a specific pod


```sh
$ kubectl logs <podname> <container name>
```
- Displays logs of the pod
- Options:
  - `-f`: follow logs


### 2.1.2 Contexts

#### See all available contexts

```sh
$ kubectl config get-contexts
```


# 3 - Helmfile commands

## 3.1 Checking

Checking the difference of the local helmfile before deploying it is a good idea, to make sure only what is needed is applied:
```sh
$ helmfile diff
```
- Returns the differences between the local helmfile and the one in the cloud

## 3.1 Applying changes

Apply changes of the local helmfile on the deployed one.
```sh
$ helmfile apply
```
