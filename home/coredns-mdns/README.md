# Manually compile locally with Docker

Run this to get a binary with appropriate modules using a local image:

```
docker build -f build.Dockerfile -t coredns .
docker cp $(docker create --rm coredns):/build/coredns/coredns .
docker run --rm -v $PWD:/v -w /v golang:1.14 ./coredns -plugins
```

# Build, push, and deploy

```
source $(multiwerf use 1.2 beta --as-file)
export WERF_KUBECONFIG=<path to your kube config. e.g. ~/.kube/config>
cd ../../ # root of git repo
werf converge --repo johntron/coredns-mdns --values home/coredns-mdns/chart/custom-values.yaml --config home/coredns-mdns/werf.yamlm
```

# Uninstall

```
export WERF_KUBECONFIG=<path to your kube config. e.g. ~/.kube/config>
cd ../../ # root of git repo
werf dismiss coredns-mdns
```