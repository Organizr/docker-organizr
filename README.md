# [organizr/organizr](https://github.com/organizr/docker-base)

[![Size](https://img.shields.io/docker/image-size/organizr/organizr?color=402885&style=for-the-badge)](https://hub.docker.com/r/organizr/organizr/)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/organizr/docker-organizr/Build%20Container?color=402885&style=for-the-badge&logo=github&logoColor=41add3)](https://github.com/organizr/docker-organizr/actions?query=workflow%3A%22Build+Container%22)
[![Docker Pulls](https://img.shields.io/docker/pulls/organizr/organizr?color=402885&style=for-the-badge&logo=docker&logoColor=41add3)](https://hub.docker.com/r/organizr/organizr/)
[![Discord Chat](https://img.shields.io/discord/374648602632388610?color=402885&logo=discord&logoColor=41add3&style=for-the-badge)](https://organizr.app/discord)
[![License](https://img.shields.io/github/license/organizr/docker-organizr?color=402885&style=for-the-badge)](LICENSE.md)

An HTPC/Homelab services organizer that is written in PHP.

## Usage

```bash
docker create \
  --name=organizr \
  -v /path/to/data:/config \
  -e PGID=1000 -e PUID=1000  \
  -p 80:80 \
  -e branch="v2-master" `#optional` \
  ghcr.io/organizr/organizr
```

Entries marked with `optional` is showing the default value

**Note:** Organizr is not contained inside the image, this means that using the built-in updater does not break your install. However the prefered way to update organizr is to restart the container, as we grab the latest commit on startup.

## Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container. So `-p 8080:80` would expose port 80 from inside the container to be accessible from the host's IP on port 8080 and `http://192.168.x.x:8080` would show you what's running INSIDE the container on port 80.

* `-p 80` - The port(s)
* `-v /config` - Mapping the config files for Organizr
* `-e PGID` Used for GroupID - see below for explanation
* `-e PUID` Used for UserID - see below for explanation
* `-e branch` Used to switch between branches of organizr. Valid values are(comma separated) `v2-master, master, v2-develop, develop, dev`. v2-master and master will yield the v2-master branch. v2-develop, develop and dev will yield the v2-develop branch

It is based on Alpine Linux with an s6 overlay.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```bash
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## .original and .rework files

Sometimes we change files that is used by the container, in this case we backup your old files, and replace them with the new ones.

## Multi-arch

Manifested docker images built with buildkit.

Supported architetures:

| Architecture | Tag          |
| :----------: | ------------ |
|    x86-64    | linux-amd64  |
|    arm64     | linux-arm64  |
|    armhf     | linux-arm-v7 |

## Migration

This is a drop-in replacement coming from `organizrtools/organizr-v2`.

Key-changes:

* The nginx config file for the healthcheck is moved to it's own file, under `/config/nginx/site-confs/healthcheck`.

* Moving the install directory from `/config/www/Dashboard` to `/config/www/organizr`, Nginx should also be updated with this change.

* One tag. ~~While we could have set PHP to use the unix socket as default, we opted to using a environment varible~~ We have now set up to use the unix socket exclusively. We also moved the branch selector to be a environment variable.

| Old                                     | New                                       |
| --------------------------------------- | ----------------------------------------- |
| `organizrtools/organizr-v2`             | `ghcr.io/organizr/organizr`               |
| `organizrtools/organizr-v2:dev`         | `-e branch=dev ghcr.io/organizr/organizr` |
| `organizrtools/organizr-v2:php-fpm`     | `ghcr.io/organizr/organizr`               |
| `organizrtools/organizr-v2:dev-php-fpm` | `-e branch=dev ghcr.io/organizr/organizr` |

* `organizrtools/organizr-v2:plex` and `organizrtools/organizr-v2:dev-plex` does not have a migration path.

## Setting up the application

Setup accounts, service tabs, etc. via the webUI. More info can be found on the official [Organizr GitHub repository](https://github.com/causefx/Organizr/).

## Info

* Shell access whilst the container is running: `docker exec -it organizr /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f organizr`

### Credits

* [causefx](https://github.com/causefx) - The man behind Organizr
* [Chris Yocum](https://github.com/christronyxyocum) - For creating, and maintaining the original container
* [Roxedus](https://github.com/roxedus) - For updating and redoing the CI pipeline and container
