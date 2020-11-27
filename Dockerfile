FROM golang AS build

MAINTAINER Neszt Tibor <tibor@neszt.hu>

RUN \
	git clone --depth=1 https://github.com/go-graphite/carbonapi.git && cd carbonapi && \
	CGO_ENABLED=0 go build ./cmd/carbonapi && \
	strip ./carbonapi

FROM scratch

COPY --from=build /go/carbonapi/carbonapi /

VOLUME /data

CMD ["/carbonapi", "-config", "/data/carbonapi.conf"]
