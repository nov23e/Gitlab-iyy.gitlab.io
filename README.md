## Building the Hugo Docker images

This branch builds a new Docker image everytime a new Hugo release is out.

[`update.py`](update.py) is run every 24h and checks if there's a new Hugo
release. If it finds one, the [`Dockerfile`](Dockerfile) is updated and a new
Docker image is built and pushed to the [Container Registry](https://gitlab.com/pages/hugo/container_registry).

## How to use the Hugo Pages site

See <https://gitlab.com/pages/hugo/-/blob/master/README.md>.
