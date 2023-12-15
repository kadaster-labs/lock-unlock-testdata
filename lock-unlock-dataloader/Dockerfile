FROM eclipse-temurin:17-jre-alpine

ENV LANG C.UTF-8

RUN set -eux; \
    apk -U upgrade; \
    apk add bash curl ca-certificates findutils coreutils procps git; \
    rm -rf /var/cache/apk/*


# Update below according to https://jena.apache.org/download/
# and checksum for apache-jena-4.x.x.tar.gz.sha512
ENV JENA_SHA512 c1097988fda802d157d031ba79007fd949a8ca2556bb383134021f48b44ade511ba6e2690ac4b1548c57df0476267f18ffce94101a87e094c0a161a78766d341
ENV JENA_VERSION 4.10.0
ENV ASF_MIRROR https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=
ENV ASF_ARCHIVE https://archive.apache.org/dist/


WORKDIR /tmp
# sha512 checksum
RUN echo "$JENA_SHA512  jena.tar.gz" > jena.tar.gz.sha512
# Download/check/unpack/move in one go (to reduce image size)
RUN     (curl --location --silent --show-error --fail --retry-connrefused --retry 3 --output jena.tar.gz ${ASF_MIRROR}jena/binaries/apache-jena-$JENA_VERSION.tar.gz || \
         curl --fail --silent --show-error --retry-connrefused --retry 3 --output jena.tar.gz $ASF_ARCHIVE/jena/binaries/apache-jena-$JENA_VERSION.tar.gz) && \
	sha512sum -c jena.tar.gz.sha512 && \
	tar zxf jena.tar.gz && \
	mv apache-jena* /jena && \
	rm jena.tar.gz* && \
	cd /jena && rm -rf *javadoc* *src* bat

# Add to PATH
ENV PATH $PATH:/jena/bin
# Check it works
RUN riot  --version


WORKDIR /rdf

# Create Fuseki user, so that the created TDB2 files are the right permissions
# for the Fuseki container to use. See fuseki-docker/Dockerfile
ARG JENA_USER=fuseki
ARG JENA_GROUP=$JENA_USER
ARG JENA_GID=1000
ARG JENA_UID=1000

RUN addgroup -g "${JENA_GID}" "${JENA_GROUP}" && \
    adduser "${JENA_USER}" -G "${JENA_GROUP}" -s /bin/ash -u "${JENA_UID}" -H -D

RUN mkdir --parents /rdf && \
    chown -R $JENA_USER /rdf

COPY ./prep_tdb2.sh ./
RUN chmod +x ./prep_tdb2.sh

USER $JENA_USER

CMD ["/jena/bin/riot"]