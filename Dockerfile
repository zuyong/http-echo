ARG GOLANG_VER=1.11
ARG ALPINE_VER=3.8
##### build stage ###########################################################
FROM golang:${GOLANG_VER}-alpine${ALPINE_VER} as golang

ADD . /go/src/
RUN cd /go/src/; go build -o /go/bin/http-echo


##### run stage #############################################################
FROM alpine:${ALPINE_VER}

LABEL author=yong.zu
LABEL email=yong.zu@thomsonreuters.com

ENV EXPOSE_PORT=5678

EXPOSE ${EXPOSE_PORT}/tcp
COPY --from=golang /go/bin/http-echo       /usr/local/bin/http-echo

ENTRYPOINT ["/usr/local/bin/http-echo"]
