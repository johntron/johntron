# Prerequisite

If using persistent volume on Rancher, install [local-path-provisioner](https://github.com/rancher/local-path-provisioner):

```
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
```

# Installation

```
kubectl create namespace home-assistant
helm repo add k8s-at-home https://k8s-at-home.com/charts/
helm repo update
# old:
helm template home-assistant k8s-at-home/home-assistant -f values.yaml > kustomize/manifests.yaml
kubectl -k kustomize apply

# new:
helm upgrade --install home-assistant k8s-at-home/home-assistant -f values.yaml --namespace home-assistant
```

Tailscale: https://tailscale.com/kb/1185/kubernetes/#sample-proxy
```

# Be sure to edit proxy.yaml first

cd tailscale/docs/k8s

# Setup secret and rbac
kubectl create secret generic tailscale-auth --from-literal=TS_AUTH_KEY={{ key goes here }}
export SA_NAME=default
export TS_KUBE_SECRET=tailscale-auth
make rbac

export TS_DEST_IP="$(kubectl get svc home-assistant -o=jsonpath='{.spec.clusterIP}')"
make proxy
```

Uninstall:
```
helm uninstall home-assistant
```
