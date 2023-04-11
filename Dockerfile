# Dockerfile for Hugo (HUGO=hugo) / Hugo Extended (HUGO=hugo_extended)
# HUGO_VERSION / HUGO_SHA / HUGO_EXTENDED_SHA is automatically updated
# by update.py when new release is available on the upstream.

FROM golang:1.20-alpine
ARG HUGO=hugo
ARG HUGO_VERSION=0.111.3
RUN set -eux && \
    case ${HUGO} in \
      hugo) \
        TAGS_EXTENDED="" ;; \
      *_extended) \
        TAGS_EXTENDED="--tags extended" ; \
        CGO_ENABLED=1 ;; \
    esac && \
    apk add git build-base && \
    go install ${TAGS_EXTENDED} github.com/gohugoio/hugo@v${HUGO_VERSION}

# Second stage - build the final image with minimal apk dependencies.
FROM alpine:3.16
ARG HUGO=hugo
COPY --from=0 /go/bin/hugo /usr/bin
# libc6-compat & libstdc++ are required for extended SASS libraries
# ca-certificates are required to fetch outside resources (like Twitter oEmbeds)
RUN apk add --no-cache ca-certificates libc6-compat libstdc++ git tzdata && \
    hugo version
EXPOSE 1313
WORKDIR /src
CMD ["/usr/bin/hugo"]
