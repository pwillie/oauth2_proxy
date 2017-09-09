FROM golang:1.9-alpine

RUN apk -U add bash git openssl

WORKDIR /go/src/github.com/bitly/oauth2_proxy/

COPY ./ ./

RUN wget -qO- https://raw.githubusercontent.com/pote/gpm/v1.4.0/bin/gpm | bash

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o oauth2_proxy

FROM scratch
WORKDIR /
COPY --from=0 /go/src/github.com/bitly/oauth2_proxy/oauth2_proxy .
ENTRYPOINT ["/oauth2_proxy"]
EXPOSE 4180
