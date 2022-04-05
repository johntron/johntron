## Installing the operator

From [elastic.co](https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-install-helm.html):

```
helm repo add elastic https://helm.elastic.co
helm repo update
helm install elastic-operator-crds elastic/eck-operator-crds
kubectl create namespace elastic
helm install elastic-operator elastic/eck-operator -n elastic-system --create-namespace \
  --set=installCRDs=false \
  --set=managedNamespaces='{elastic}' \
  --set=createClusterScopedResources=false \
  --set=webhook.enabled=false \
  --set=config.validateStorageClass=false
```

## Install elasticsearch:
```
kubens elastic
kubectl apply -f manifests/elasticsearch.yml

# get password for `elastic` user:
kubectl get secret elasticsearch-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'
open https://192.168.1.68:9200
# Login with password printed from previous command
```

## Install Kibana

```
kubens elastic
kubectl apply -f manifests/kibana.yml
open https://192.168.1.69:5601/
# login with 'elastic' and password obtained during "Install elasticsearch" (above)
```

## Install Fleet server and an elastic agent

```
kubens elastic
kubectl apply -f manifests/fleet.yml
```