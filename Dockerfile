# Builder image
FROM golang:1.4 as source
COPY . /opt/go
WORKDIR /opt/go

RUN set -ex \
    && cd src/ \
    && ./all.bash

# Main image
FROM ubuntu:16.04
COPY --from=source /opt/go /usr/local/go

RUN set -ex \
    && apt-get install make

ENV GOROOT=/usr/local/go
ENV GOPATH=/go

RUN set -ex \
    && mkdir $GOPATH \
    && mkdir $GOPATH/src \
    && chmod -R 777 $GOPATH \
    && rm -rf /usr/local/go/src/* \
    && ln -s /usr/local/go/bin/go /usr/local/bin

