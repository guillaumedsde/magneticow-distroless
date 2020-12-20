#!/bin/bash

OS="$(echo $TARGETPLATFORM | cut -f1 -d '/')"
ARCH="$(echo $TARGETPLATFORM | cut -f2 -d '/')"

GOOS="$OS" GOARCH="$ARCH" make magneticow

if [[ "$TARGETPLATFORM" == "$BUILDPLATFORM" ]]; then
    BINARY="/go/bin/magneticow"
else
    BINARY="/go/bin/${OS}_${ARCH}/magneticow"
fi

cp "$BINARY" ./magneticow
