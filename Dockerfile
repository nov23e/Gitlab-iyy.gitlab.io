FROM alpine:latest

ENV HUGO_VERSION 0.55.5
ENV HUGO_SHA e330a0f31f1d65c7711e357b7194f44cc5feedfa00ade7c717889ef603f1954e

# Install HUGO
RUN set -eux && \
    apk add --update --no-cache \
      ca-certificates \
      openssl \
      git && \
  wget -O ${HUGO_VERSION}.tar.gz https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
  echo "${HUGO_SHA}  ${HUGO_VERSION}.tar.gz" | sha256sum -c && \
  tar xf ${HUGO_VERSION}.tar.gz && mv hugo* /usr/bin/hugo && \
  rm -rf  ${HUGO_VERSION}.tar.gz && \
  rm -rf /var/cache/apk/* && \
  hugo version

EXPOSE 1313

CMD ["/usr/local/bin/hugo"]
