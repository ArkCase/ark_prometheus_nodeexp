FROM 345280441424.dkr.ecr.ap-south-1.amazonaws.com/ark_base:latest

ARG ARCH="amd64"
ARG OS="linux"
ARG VER="1.2.0"
ARG PKG="node_exporter"
ARG SRC="${PKG}-${VER}.${OS}-${ARCH}"
ARG UID="nobody"
ARG GID="nobody"

LABEL ORG="Armedia LLC"
LABEL MAINTAINER="Armedia LLC"
LABEL APP="Prometheus Node Exporter"
LABEL VERSION="${VER}"
LABEL IMAGE_SOURCE="https://github.com/ArkCase/ark_prometheus_nodeexp"

# Modify to fetch from S3 ...
RUN curl \
        -L "https://github.com/prometheus/${PKG}/releases/download/v${VER}/${SRC}.tar.gz" \
        -o - | tar -xzvf -
RUN mv -vif \
        "${SRC}/LICENSE" \
        "/LICENSE"
RUN mv -vif \
        "${SRC}/NOTICE" \
        "/NOTICE"
RUN mv -vif \
        "${SRC}/node_exporter" \
        "/bin/node_exporter"
RUN rm -rvf \
        "${SRC}"

USER        ${UID}
EXPOSE      9100
ENTRYPOINT  [ "/bin/node_exporter" ]
