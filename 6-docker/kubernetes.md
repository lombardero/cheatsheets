



```sh
$ kubectl get pods
```
- List all pods currently running and reachable
- Options:
  - `--namespace=<bla>`: specify the namespace to excute the command for (will use
  - the default namespace)

```sh
$ kubectl config get-contexts
```

```sh
$ kubectl config set-context --current --namespace=<bla>
```
- Set default namespace
- Options:
  - `-w`: keep it active


```
$
```

Steps:
- Make sure docker / kubernetes is pointing to right environment: Docker UI > Kubernetes > select env
- Check current pods:
```
$ kubectl get pods --namespsce=fca
```
- Delete pods one by one:
```
$ kubectl delete pod <pod name> --namespace=fca
```

Check details of a pod:
```
$ kubectl describe pod <podname> --namespace=<bla>
```
- List all containers in that pod and their status

> Note: the `Image` field on each container is the image tag on docker hub, its format is
> ```
> <organization>/<repository>:<id>.<commit hash>
> ```



```
$ kubectl logs <podname> <container name>
```
- Options:
  - `-f`: follow logs



How to deploy a new version of a service.

> Note: the `helmfile` command is required, for that, clone the `picnic-infra-kubernetes` repository, and run the `client.sh`
> shell script inside the `infra` folder.

Step 1: Change the Image ID for which to deploy the service.

For that, go to the `deployments` folder in the `picnic-fca` repository. Open the directory of the desired environment and the desired service to redeploy. Open the `<file>.values.yaml` file, and fill in the desired `tag` (go to Dockerhub to check)

Check the difference of the helmfile is just the changed lines:
```
$ helmfile diff
```

Apply such changes
```
$ helmfile apply
```
