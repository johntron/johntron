FROM golang:alpine AS build
WORKDIR /build
RUN apk add git make
RUN git clone --depth 1 --branch v1.7.1 https://github.com/coredns/coredns
WORKDIR /build/coredns
RUN printf "mdns:github.com/openshift/coredns-mdns\n" >> plugin.cfg
RUN cat plugin.cfg
RUN make

FROM scratch
WORKDIR /
COPY --from=build /build/coredns/coredns .
ENTRYPOINT [ "/coredns" ]