ARG BASE_IMAGE
FROM ${BASE_IMAGE:-organizr/base:2020-08-01_20}

LABEL maintainer="christronyxyocum,Roxedus"

LABEL org.label-schema.name="organizr/Organizr" \
      org.label-schema.description="Docker image for Organizr" \
      org.label-schema.url="https://organizr.app/" \
      org.label-schema.vcs-url="https://github.com/organizr/docker-organizr" \
      org.label-schema.schema-version="1.0"

ENV fpm="false" branch="v2-master"

# add local files
COPY root/ /


# ports and volumes
EXPOSE 80
VOLUME /config
