# Dockerfile for Hugo (HUGO=hugo) / Hugo Extended (HUGO=hugo_extended)
# HUGO_VERSION / HUGO_SHA / HUGO_EXTENDED_SHA is automatically updated
# by update.py when new release is available on the upstream.
# Use multi-stage builds to make images optimized in size.

FROM golang:1.20-bullseye
ARG HUGO=hugo
ARG HUGO_VERSION=0.111.3
ARG HUGO_SHA=61500f6d39a23d36b946a9f44611c804aec4f1379d6113528672b1ac3077397a
ARG HUGO_EXTENDED_SHA=b382aacb522a470455ab771d0e8296e42488d3ea4e61fe49c11c32ec7fb6ee8b
RUN set -eux && \
    case ${HUGO} in \
      *_extended) \
        HUGO_SHA="${HUGO_EXTENDED_SHA}" ;; \
    esac && \
    apt update && \
    apt install ca-certificates openssl tzdata git && \
    wget -O ${HUGO_VERSION}.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO}_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    echo "${HUGO_SHA}  ${HUGO_VERSION}.tar.gz" | sha256sum -c && \
    tar xf ${HUGO_VERSION}.tar.gz && mv hugo* /usr/bin/hugo && \
    hugo version
EXPOSE 1313
WORKDIR /src
CMD ["/usr/bin/hugo"]
