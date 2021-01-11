Compile with appropriate modules:

```
docker build -f build.Dockerfile -t coredns .
docker cp $(docker create --rm coredns):/build/coredns/coredns .
docker run --rm -v $PWD:/v -w /v golang:1.14 ./coredns -plugins.
```

Deploy:

```
helm upgrade --install coredns .
```
