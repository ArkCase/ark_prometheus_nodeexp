FROM 345280441424.dkr.ecr.ap-south-1.amazonaws.com/ark_base:latest

#
# Basic Parameters
#
ARG ARCH="amd64"
ARG OS="linux"
ARG VER="1.2.0"
ARG PKG="node_exporter"
ARG SRC="${PKG}-${VER}.${OS}-${ARCH}"
ARG UID="prometheus"

#
# Some important labels
#
LABEL ORG="Armedia LLC"
LABEL MAINTAINER="Armedia Devops Team <devops@armedia.com>"
LABEL APP="Prometheus Node Exporter"
LABEL VERSION="${VER}"
LABEL IMAGE_SOURCE="https://github.com/ArkCase/ark_prometheus_nodeexp"

#
# Create the required user
#
RUN useradd --system --user-group "${UID}"

#
# Download the primary artifact
#
RUN curl \
        -L "https://github.com/prometheus/${PKG}/releases/download/v${VER}/${SRC}.tar.gz" \
        -o - | tar -xzvf -

#
# Deploy the extracted files
#
RUN mv -vif "${SRC}/LICENSE"       "/LICENSE"
RUN mv -vif "${SRC}/NOTICE"        "/NOTICE"
RUN mv -vif "${SRC}/node_exporter" "/usr/bin/node_exporter"

#
# Cleanup
#
RUN rm -rvf "${SRC}"

#
# Final parameters
#
USER        ${UID}
EXPOSE      9100
ENTRYPOINT  [ "/usr/bin/node_exporter" ]
