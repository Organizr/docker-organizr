ARG BASE_IMAGE
FROM ${BASE_IMAGE:-organizr/base:2020-10-23_20}

LABEL maintainer="christronyxyocum,Roxedus"

ENV fpm="false" branch="v2-master"

# add local files
COPY root/ /


# ports and volumes
EXPOSE 80
VOLUME /config
