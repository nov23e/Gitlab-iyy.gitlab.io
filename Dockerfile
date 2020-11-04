# Dockerfile for Hugo (HUGO=hugo) / Hugo Extended (HUGO=hugo_extended)
# HUGO_VERSION / HUGO_SHA / HUGO_EXTENDED_SHA is automatically updated
# by update.py when new release is available on the upstream.
# Utilize multi-stage builds to make images optimized in size.

# First stage - download prebuilt hugo binary from the GitHub release.
# Use golang image to run https://github.com/yaegashi/muslstack
# on hugo executable to extend its default thread stack size to 8MB
# to work around segmentation fault issues.
FROM golang:1.13-alpine
ARG HUGO=hugo
ARG HUGO_VERSION=0.78.0
ARG HUGO_SHA=72964765fba61950d4ebb0d131f2cb585f26cddb4ee189e65d874263d2b70839
ARG HUGO_EXTENDED_SHA=2c3d888439765d10d0713a197681c4ecd06c1aa14367d8f4eb3ad69f64c9714b
RUN set -eux && \
    case ${HUGO} in \
      *_extended) \
        HUGO_SHA="${HUGO_EXTENDED_SHA}" ;; \
    esac && \
    apk add --update --no-cache ca-certificates openssl git && \
    wget -O ${HUGO_VERSION}.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO}_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    echo "${HUGO_SHA}  ${HUGO_VERSION}.tar.gz" | sha256sum -c && \
    tar xf ${HUGO_VERSION}.tar.gz && mv hugo* /usr/bin/hugo
RUN go get github.com/yaegashi/muslstack
RUN muslstack -s 0x800000 /usr/bin/hugo

# Second stage - build the final image with minimal apk dependencies.
# alpine:edge is required for muslstack to work as of June 2019.
FROM alpine:edge
ARG HUGO=hugo
COPY --from=0 /usr/bin/hugo /usr/bin
RUN set -eux && \
    case ${HUGO} in \
      *_extended) \
        apk add --update --no-cache libc6-compat libstdc++ && \
        rm -rf /var/cache/apk/* ;; \
    esac && \
    hugo version
EXPOSE 1313
WORKDIR /src
CMD ["/usr/bin/hugo"]
