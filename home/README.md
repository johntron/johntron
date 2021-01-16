## Technologies

* CoreDNS
* Traefik
* OpenPolicyAgent
* OpenFaaS
* CIS Benchmark
* k9scli.io


Install:

```
(cd metallb && helm upgrade --install metallb bitnami/metallb -f chart/values.yaml)
(cd coredns && helm upgrade --install coredns coredns/coredns -f chart/values.yaml)
(cd gocd && helm upgrade --install gocd gocd/gocd -f chart/values.yaml)
```

Uninstall:

```
helm uninstall metallb gocd coredns
```