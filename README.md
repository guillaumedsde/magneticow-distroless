# [🐋 Magneticow-distroless](https://github.com/guillaumedsde/magneticow-distroless)

[![Gitlab pipeline status](https://img.shields.io/gitlab/pipeline/guillaumedsde/magneticow-distroless)](https://guillaumedsde.gitlab.io/magneticow-distroless/)
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/guillaumedsde/magneticow-distroless)](https://hub.docker.com/r/guillaumedsde/magneticow-distroless/tags)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/guillaumedsde/magneticow-distroless)](https://hub.docker.com/r/guillaumedsde/magneticow-distroless)
[![Docker Pulls](https://img.shields.io/docker/pulls/guillaumedsde/magneticow-distroless)](https://hub.docker.com/r/guillaumedsde/magneticow-distroless)
[![GitHub stars](https://img.shields.io/github/stars/guillaumedsde/magneticow-distroless?label=Github%20stars)](https://github.com/guillaumedsde/magneticow-distroless)
[![GitHub watchers](https://img.shields.io/github/watchers/guillaumedsde/magneticow-distroless?label=Github%20Watchers)](https://github.com/guillaumedsde/magneticow-distroless)
[![Docker Stars](https://img.shields.io/docker/stars/guillaumedsde/magneticow-distroless)](https://hub.docker.com/r/guillaumedsde/magneticow-distroless)
[![GitHub](https://img.shields.io/github/license/guillaumedsde/magneticow-distroless)](https://github.com/guillaumedsde/magneticow-distroless/blob/master/LICENSE.md)

This repository contains the code to build a small and secure **[distroless](https://github.com/GoogleContainerTools/distroless)** **docker** image for **[Magneticow](https://github.com/boramalper/magnetico)** which can be run as an unprivileged user.
The final images are built and hosted on the [dockerhub](https://hub.docker.com/r/guillaumedsde/magneticow-distroless) and the documentation is hosted on [gitlab pages](https://guillaumedsde.gitlab.io/magneticow-distroless/)

## ✔️ Features summary

- 🥑 [distroless](https://github.com/GoogleContainerTools/distroless) minimal image
- 🤏 As few Docker layers as possible
- 🛡️ only basic runtime dependencies
- 🛡️ Runs as unprivileged user with minimal permissions

## 🏁 How to Run

### `docker run`

```bash
$ docker run  -v /your/config/path/:/config \
              -v /your/date/path/:/data \
              -v /etc/localtime:/etc/localtime:ro \
              --user "$(id -u):$(id -g)" \
              guillaumedsde/magneticow-distroless:latest
```

### `docker-compose.yml`

```yaml
version: "3.3"
services:
  magneticow-distroless:
    volumes:
      - "/your/config/path/:/config"
      - "/your/date/path/:/data"
      - "/etc/localtime:/etc/localtime:ro"
    user: 1000:1000
    read_only: true
    image: "guillaumedsde/magneticow-distroless:latest"
```

## 🖥️ Supported platforms

This container is built for many hardware platforms:

- linux/amd64
- linux/arm64
- linux/arm
- linux/ppc64le

All you have to do is use a recent version of docker and it will pull the appropriate version of the image from the docker hub.

## 🙏 Credits

A couple of projects really helped me out while developing this container:

- 💽 [Magneticow](https://github.com/boramalper/magnetico) _the_ awesome software
- 🥑 [Google's distroless](https://github.com/GoogleContainerTools/distroless) base docker images
- 🐋 The [Docker](https://github.com/docker) project (of course)
