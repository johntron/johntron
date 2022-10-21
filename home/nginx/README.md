```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm upgrade --install nginx bitnami/nginx -f values.yaml --namespace nginx
```

# Tailscale

Instructions: https://tailscale.com/kb/1185/kubernetes/#sample-proxy

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
