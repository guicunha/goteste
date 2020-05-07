FROM golang:1.10-alpine3.8 AS temp

RUN apk add --no-cache --update git

ADD ./src /go/src/app

WORKDIR /go/src/app

RUN go get -d -v \
  && go install -v \
  && go build

##

FROM scratch
COPY --from=temp /go/bin/app /go/bin/
CMD ["/go/bin/app"]