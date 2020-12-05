ARG MAGNETICOW_VERSION=v0.12.0

FROM alpine:latest as base

ARG MAGNETICOW_VERSION

ADD https://github.com/boramalper/magnetico/releases/download/$MAGNETICOW_VERSION/magneticow /magneticow

RUN chmod 755 /magneticow

FROM gcr.io/distroless/base-debian10:latest

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG MAGNETICOW_VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="jackett-distroless" \
    org.label-schema.description="Distroless container for the Magneticow program" \
    org.label-schema.url="https://guillaumedsde.gitlab.io/magneticow-distroless/" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.version=$MAGNETICOW_VERSION \
    org.label-schema.vcs-url="https://github.com/guillaumedsde/magneticow-distroless" \
    org.label-schema.vendor="guillaumedsde" \
    org.label-schema.schema-version="1.0"

COPY --from=base /magneticow /magneticow

VOLUME /data
VOLUME /config

EXPOSE 8080

ENV XDG_CONFIG_HOME=/config \
    XDG_DATA_HOME=/data


ENTRYPOINT [ "/magneticow" ]