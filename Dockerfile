# syntax = docker/dockerfile:1.0-experimental
ARG MAGNETICOW_VERSION=v0.12.0

# hadolint ignore=DL3029
FROM --platform=$BUILDPLATFORM golang:1.15-buster AS build

ARG MAGNETICOW_VERSION

WORKDIR /magnetico

RUN git clone https://github.com/boramalper/magnetico.git . \
    && git checkout "${MAGNETICOW_VERSION}"

RUN go get -u github.com/kevinburke/go-bindata/...

ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN printf "run: %s \nbuild: %s\n" "$BUILDPLATFORM" "$TARGETPLATFORM"

COPY build/build_binary.sh ./

SHELL ["/bin/bash", "-x", "-o", "pipefail", "-c"]
RUN chmod +x ./build_binary.sh \
    && ./build_binary.sh

RUN mkdir /data

FROM gcr.io/distroless/cc-debian10:nonroot

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG MAGNETICOW_VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="magneticow-distroless" \
    org.label-schema.description="Distroless container for the Magneticow program" \
    org.label-schema.url="https://guillaumedsde.gitlab.io/magneticow-distroless/" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.version=$MAGNETICOW_VERSION \
    org.label-schema.vcs-url="https://github.com/guillaumedsde/magneticow-distroless" \
    org.label-schema.vendor="guillaumedsde" \
    org.label-schema.schema-version="1.0"

COPY --from=build /magnetico/magneticow /magneticow

VOLUME /data
VOLUME /config

# Copy empty directory to /data and /config volumes
# to fix permissions until this is fixed:
# https://github.com/moby/moby/issues/2259
COPY --chown=nonroot:nonroot --from=build /data /data
COPY --chown=nonroot:nonroot --from=build /data /config

ENV XDG_CONFIG_HOME=/config \
    XDG_DATA_HOME=/data

ENTRYPOINT [ "/magneticow" ]