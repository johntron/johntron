Install:

```
kubectl create namespace metallb
helm upgrade --install metallb bitnami/metallb -f chart/values.yaml --namespace metallb

