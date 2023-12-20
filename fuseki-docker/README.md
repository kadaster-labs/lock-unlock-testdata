# Fuseki Docker

This is a straight replica of the [Fuseki
Dockerfile](https://github.com/apache/jena/blob/main/jena-fuseki2/jena-fuseki-docker/Dockerfile) of
the [Fuseki2 Docker package](https://jena.apache.org/documentation/fuseki2/fuseki-docker.html). It
is replicated 'cause it is not published publically. In this repo there's a GitHub Actions pipeline
that builds it automatically and pushes it (from `main` branch only) to the [GitHub Container
Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)

Differences with the original `Dockerfile`:

- using `jena-fuseki-fulljar` instead of `jena-fuseki-server` so the UI will be available as well
- adding `jena-fuseki-war` (webapp) for the UI parts

## Usage

Use the published image by:

```bash
$ docker pull ghcr.io/lock-unlock-testdata/fuseki:4.10.0
```

Local build:

```bash
$ docker build --build-arg JENA_VERSION=4.10.0 -t lock-unlock-testdata/fuseki:4.10.0 ./fuseki-docker
```
