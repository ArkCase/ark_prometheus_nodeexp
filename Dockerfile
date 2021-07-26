ARG ARCH="amd64"
ARG OS="linux"
#FROM quay.io/prometheus/busybox-${OS}-${ARCH}:latest
FROM 345280441424.dkr.ecr.ap-south-1.amazonaws.com/ark_base:latest
LABEL maintainer="Armedia, LLC"

ARG ARCH="amd64"
ARG OS="linux"
ARG VER="1.2.0"
ARG PKG="node_exporter"
ARG SRC="${PKG}-${VER}.${OS}-${ARCH}"

RUN curl -L "https://github.com/prometheus/${PKG}/releases/download/v${VER}/${SRC}.tar.gz" -o package.tar.gz
RUN tar -xzvf "package.tar.gz"
RUN mv -vif "${SRC}/LICENSE"                     "/LICENSE"
RUN mv -vif "${SRC}/NOTICE"                      "/NOTICE"

RUN mv -vif "${SRC}/node_exporter"               "/bin/node_exporter"

# Cleanup
RUN rm -rvf "${SRC}" package.tar.gz

USER        nobody
EXPOSE      9100
ENTRYPOINT  [ "/bin/node_exporter" ]
