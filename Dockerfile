# Dockerfile for Hugo (HUGO=hugo) / Hugo Extended (HUGO=hugo_extended)
# HUGO_VERSION / HUGO_SHA / HUGO_EXTENDED_SHA is automatically updated
# by update.py when new release is available on the upstream.
# Use multi-stage builds to make images optimized in size.

FROM golang:1.20-bullseye
ARG HUGO=hugo
ARG HUGO_VERSION=0.110.0
ARG HUGO_SHA=a1c97b69a96040e0911f8ce8c9718553c333727b5ffa969e59635837e3b4dcc3
ARG HUGO_EXTENDED_SHA=008519ae58e7650097da8d557d788841f057359b3b695508abcfa855e9779b38
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
