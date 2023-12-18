# 🔒-🔓-dataloader

Docker image containing tooling to help deploying the lock-unlock stack

Contains:
- Jena tooling
- Git

This docker image exposes the [Apache Jena](https://jena.apache.org/)
command line tool [riot](https://jena.apache.org/documentation/io/#command-line-tools)
and its variants (e.g. `turtle`, `rdfxml`), in addition to the other Jena
command line tools, like `rdfcompare`, `tdbloader` and `sparql`.

## Requirements

- Docker
- A `.ttl` file publicly hosted somewhere. It may be gzipped.

This might change in the future to provide more flexibility.

## Acknowledgement

This is mostly a fork of [stain/jena-docker](https://github.com/stain/jena-docker),
with some extras included. Please refer to that repo for instructions for more
info on everything this image has to offer.

## Usage

First build the image:

```bash
docker build -t lock-unlock-dataloader:latest ./lock-unlock-dataloader
```

The following example is for the brk dataset.

```bash
mkdir database
docker run --rm \
    -v ${PWD}/database:/database \
    -e FILE_URL="https://raw.githubusercontent.com/kadaster-labs/lock-unlock-testdata/main/testdata-brk/lock-unlock-brk.ttl.gz" \
    lock-unlock-dataloader \
    ./prep_tdb2.sh
```

By default, the image writes the tdb2 data to /database. Use Docker volume to mount local folder.

With the data available in `./database/`, you could then start the Fuseki container:
```bash
docker run --rm \
    -p 3030:3030 \
    -v ${PWD}/database:/fuseki/databases/brk \
    lock-unlock-testdata/fuseki:4.10.0 --tdb2 --loc /fuseki/databases/brk /brk
```
Details on this container can be found in the fuseki-docker folder.

The data can then be accessed at http://localhost:3030/brk
