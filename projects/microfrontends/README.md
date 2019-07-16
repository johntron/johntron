# Thoughts

* Do we really need to continue using frameworks designed to manage the entire page?
* After accepting Web Components as integration layer, how to improve server-side world?


```mermaid
graph TB
c[Dependency loading]-->o[Apps register routes]
o-->bb[SSR handlers]
bb-->k[Children waiting on parents]
k-->l[Irrelevant - parent responsible for loading/positioning child efficiently]

bb-->q[Static: return HTML]
bb-->v[Dynamic: act as functions/Promises]
v-->e[Waiting on children]
e-->f[Composer passes all handlers to each handler as Promises]
f-->m[Technology? gRPC?]
e-->n[Define loading logic in composer]

v-->w[Protocol?]
w-->x[vm.Script]
x-->y[How to load imports from handler instead of composer?]
x-->z[Performance?]
z-->aa[Node version or language differences?]
q-->u[SSI - parents instruct composer to call children]
u-->j[Must wait for parent to load before beginning child]
q-->r[No SSI - parents call children directly]
r-->t[Solves order-dependencies like login]
r-->s[Enforce performance w/budget]

a[Layout]

b[CSS]
```

```mermaid
graph TB
a[Dependency loading]-->b[Mimic browser]
b-->c[Must declare all potential routes ahead-of-time]
b-->d[Browser shares one execution context and module cache - server does/should not]
d-->e[Use import-map to mimic separate contexts?]
```

## Google Cloud (GCP)

Recommended cluster config:

* 1 node-pool with 2x n-normal-1 – these cost $$, so shutdown when not in-use
* 1 node-pool with 1x f-micro – this is free, so just leave it running

Instructions:

* [Download Istio and add bin/ to PATH](https://istio.io/docs/setup/kubernetes/download-release/)
* [Setup GKE](https://istio.io/docs/setup/kubernetes/platform-setup/gke/)
* [Install minimal control plane](https://istio.io/docs/setup/kubernetes/minimal-install/#see-also) - see helm template command below
* [Verify control plane is running](https://istio.io/docs/setup/kubernetes/quick-start/#verifying-the-installation)
* Change imageName in skaffold.yaml and image in deployment.yml Deployments to match container registry (e.g. gcr.io/johntron/composer)
* Follow instructions in "Running"
* Get IP address of ingress and open http://<ingress IP>/info


## Run locally with Minikube

* Install Docker, minikube (optional), and skaffold
* Launch minikube with `minikube start`
* Optionally start minikube dashboard with `minikube dashboard`
* Change deployments to use NodePort.
* Follow instructions in "Running"
* Expose service and open in http://<exposed IP>/info


## Running

* Inject sidecar with: istioctl kube-inject -f deployment.yml > deployment-with-sidecar.yml
* Run `skaffold dev`


## Cleaning up

* Kill `skaffold dev` - it'll remove app deployment automatically
* `kubectl delete -f istio-minimal.yaml`
* Scale down k8s cluster with `gcloud compute instance-groups managed resize`


## Using helm template to generate minimal install

```
cd istio-1.0.5
helm template install/kubernetes/helm/istio --name istio --namespace istio-system \
  --set security.enabled=false \
  --set ingress.enabled=true \
  --set gateways.istio-ingressgateway.enabled=true \
  --set gateways.istio-egressgateway.enabled=false \
  --set galley.enabled=false \
  --set sidecarInjectorWebhook.enabled=false \
  --set mixer.enabled=false \
  --set prometheus.enabled=false \
  --set global.proxy.envoyStatsd.enabled=false \
  --set pilot.sidecar=false > istio-minimal.yaml
```


## Todo

* Finish trying Bazel? https://docs.bazel.build/versions/master/build-javascript.html#step-2-installing-ibazel and https://github.com/bazelbuild/rules_nodejs