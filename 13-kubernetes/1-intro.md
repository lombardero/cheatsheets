# Kubernetes concepts

## Pods

Abstraction over 1 or more containers. Similar to docker-compose.

Pods have their own IP, and IPs are dynamic (can change after reboot). Containers have Ports (need to configure Container IP:port to the Pod one). Can contain values or references to external volumes.

Execute a command inside the Pod:
```sh
kubectl exec <pod name> <command>
```
- Command could be `curl localhost:8080`

### Pod Lifecycle

Error codes of a Pod:
- `ErrImagePull`: error pulling image
- `ImagePullBackOff`: stopped trying pulling the image for a while
- `CrashLoopBackOff`: starting pod failed two times, Kubernetes will stop trying to start it for a while.

Get the pod metadata:
```sh
kubectl describe pod <pod name>
```

See the logs:
```sh
kubectl logs <pod name>
```

```sh
kubectl get events
```

Log into a pod
```sh
kubectl exec -ti <pod name> /bin/bash
```


#### Termination

Whn kubernetes shits down a pod, it:
- Execture `preStopHook` (if configured
- Send `SIGTERM` to pod
- Wait `terminationGracePeriodSeconds` for a graceful termination (default: 30)
- Send `SIGKILL` to pod

> :exclamation: if requests are stll being handled when the `SIGKILL` signal arrives, they will not be handled gracefully

## Nodes

Virtual or physical machine where pods live. Pods are balanced over multiple nodes (the node can be known by running `kubectl describe pod <pod id>`).

## Cluster

The Kubernetes cluster contains:
- the Control Plane, which manages the Kubernetes cluster. It contains:
  - the Kubernetes API -API entrypoint-
  - sched: scheduling tasks
  - c-m: contrl manager which stops and starts pods
  - c-c-m: ?
- the Pods: all Pods have a `kubelet` instance and a `k-proxy` instance enabling the API to access and manage the Pod.

> :bulb: Kubernetes manages deployments ensuring no downtime.

### Context

Clusters in Picnic. By design, we decided that eah cluster has its own context. One Cluster can be linked to multiple contexts, but not the other way around.

Get contexts:
```sh
kubectl config get-contexts
```
- Displays contexts and clusters in that context

Changing context:
```sh
kubectl config use-context <context name>
```

> :bulb: Contexts can also be changed via the Docker Desktop app, Kubernetes field.

### Namespace

Abstraction layer to manage access to clusters.

> :exclamation: Good practice: using 

Change the namespace used in a context:
```sh
kubectl config set-context --current --namespace=<namespace>
```

## Deployments

Describe desired state in a declarative way. Deployment file used by deployment controller to manage dplayments. Can configure number of replicas, provides a template for pods.

Retrieve with:
```sh
kubactl get deployments
```

### Labels & selectors

A label is like a tag that you use to mark deployments

Selectors are used to select pods; they must match labels. In Picnic, we use `app` selector (for example: `pim`), and the `site` selector (for ex: `fc0`).

```yml
spec:
    selector:
        matchLabels: # Must match the labels below
            app: pim
            site: fc0
    template:
        metadata:
            labels:
                app: pim
                site: fc0
```

This enables, for example:
```sh
kubectl get pods --selector site=fc0
```

### Creating a deployment

Creates a deployment with a name and an image:


### Probes

Probes are tests that can be configured in Kubernetes to determine if a pod needs restarting.

#### Liveleness

Kubernetes periodically probes for liveliness to determine if a pod needs to be restarted.

Example of configuration for a test on the "health" endpoint for a service:
```yml
levenessProbe:
    httpGet:
        path: /mng/health
        port: 8080
    initialDelaySeconds: 30 # time liveness test to be done from the start
    periodSeconds: 10 # how frequently to do the test
    failureThreshold: 5 # how many times should it try until restart should happen
```
- If endpoint fails to respond 5 times, Kubernetes will restart the pod.

#### Readiness

Kubernetes periodically probes the readiness to determine if a pod is ready to receive traffic.

Example of readiness (check "health" endpoint 3 times)
```yml
levenessProbe:
    httpGet:
        path: /mng/health
        port: 8080
    initialDelaySeconds: 30 # time liveness test to be done from the start
    periodSeconds: 10 # how frequently to do the test
    failureThreshold: 3 # how many times should it try until considering service live
```

> :bulb: In Java (Spring) applications, the behavior of the `/mng/health` endoint usually can be configured for it to return successful responses once systems (DB, etc) are live. These checks can be defined in the `defaults.properties` file of the application, in which, for example, the application could wait for the Db to be up and running (for ex: once it is `ping`able)

## Services

Pods are ephemeral and have unique IP addesses, but we need consistent way to reach them. (Example: `picnic.wms`)
- A Service will retain the IP

Service types:
- `ClusterIP`: service only available in the cluster
- `NodePort`: define static port within the node (vault - keycloak)
- `LoadBalancer`: cloud provider supplies load balancer (eg AWS)
- `External name`: define a DNS name

### Exposing a service

```sh
kubectl expose deployment <deployment name> --type=<service type> --port=80 --target-port=8080
```
- Notes:
  - Type can be `LoadBalancer`, and the cloud providers will manage that behind the scenes.
- Labels:
  - `--port`: port exposed to the outside word
  - `--target-port`: port of the pod (depends on configuration)

> :exclamation: In real life, this is usually done via the Helmfile, nod direclty using this command.

### Delete service

```
kubectl delete svc
```


### Reaching services

```sh
kubectl get svc <service name>
```
- When a deployment is exposed, a service is created with the same name (:exclamation: to verify)

### Ingress

Ingress enables to reach a service from outside the cluster. It sets up a base URL and supports routing tools, enabling to call different services based on routing rules.

See an example configuration:
```yml
- host: myapp.com
    http:
        paths:
            - path: /analytics
                serviceName: analytics-service
                servicePort: 3000
            - path: /shopping
                serviceName: shopping-service
                servicePort: 8080
```

## ConfigMap

> :exclamation: Configmaps are public, do not expose secrets


## Resource limits

Pods have resource limits. This config sets up the max resources.

Auto-scaling can be enabled. But usually does not work well (it is too slow to handle peaks). Usually it is better to set it based on time (eg from 5 to 7), or "we are sending a merch e-mail".

Example configuration
```yml
resources:
    limits:
        memory: 512Mi
        cpu: 2000m
    requests:
        memory: 512Mi
        cpu: 100m
```
Notes:
- cpu: 1m == 1000th of a core
- memory: 1Mi == 1 MB of memory


> :thought_balloon: Set up a JVM limit compatible to the Pod one!

# Monitoring tools for K8s

## K9s
K9s is a monitoring tool enabling to visualize Kubernetes (CLI)

## Lens
Really cool, but requires a lot of rights to be useful. It is a UI enabling to see.
