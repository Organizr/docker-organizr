ARG BASE_IMAGE
ARG ARCH
FROM ${BASE_IMAGE:-ghcr.io/organizr/base:2023-11-30_12}-${ARCH:-linux-amd64}

LABEL maintainer="christronyxyocum,Roxedus"

ENV fpm="false" branch="v2-master"

# add local files
COPY root/ /


# ports and volumes
EXPOSE 80
VOLUME /config
