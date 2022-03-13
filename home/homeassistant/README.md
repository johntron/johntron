# Prerequisite

If using persistent volume on Rancher, install [local-path-provisioner](https://github.com/rancher/local-path-provisioner):

```
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
```

# Installation

```
helm repo add k8s-at-home https://k8s-at-home.com/charts/
helm repo update
helm template home-assistant k8s-at-home/home-assistant -f values.yaml > kustomize/manifests.yaml
kubectl -k kustomize apply
```

Uninstall:
```
helm uninstall home-assistant
```