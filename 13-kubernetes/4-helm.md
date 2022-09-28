# Helm

Ue templates instead of `yaml` files with fixed values (lots of duplicated config instead).

Uses charts (golang chart) to combine templates and create a unified configuration with defaults

## Structure

```txt
mychart/
    chart.yaml - metadata
    values.yaml - default values
    charts/ - optional charts this chart depends on
    templates/ - the actual templates
```

In picnic:
```
common/
    your-service.values.yaml - generic default values
nl-dev/
    your-service.values.yaml - default values for nl dev (overrides generic ones if available)
```

## Charts

Charts: sort of like a configuration for a service (or other). Need to identify clearly what is it.

Create your own charts to reuse configurations.

### Create a chart

```sh
helm create <chart name>
```


### Deploy a chart

```sh
helm install --name <chart name> <chart folder> --tiller-namespace <namespace>
```


### Delete a chart

```sh
helm delete --tiller-namespace <namespace> --purge <chart name>
```
- Labels:
  - `--purge`: makes sure to delete all charts

## Templates - yaml

Use references instead of hardcoded values:
```yml
- Dserver.port={{ .Values.java.port }}
```

Trim whitespace (including newlines) on the left: `{{-`, on the right: `-}}`. This is important as YAML is very indentation-specific.


# Helmfile

A file to handle all configuration:
- Deployments (in different environments)
- Charts (where are they stored). In Picnic, they are stored in nexus.

Compare the previous release with the current file:
```sh
helmfile diff
```

Synchronize state with the current helm configuration
```sh
helmfile sync
```

Helmfile apply:
```sh
helmfile -i apply
```
- Options:
  - `-i`: interactive (allows to check the results before going ahead)

Run `helmfile diff` first, and then only if changes are found, it will rn `helmfile sync`

## Tiller

Tiller is a process running on a pod that manages resources (this will be deprecated because it is a security risk). Kubernetes will remove this in the next release.
