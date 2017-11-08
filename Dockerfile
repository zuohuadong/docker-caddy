
FROM golang as builder

RUN go get github.com/abiosoft/caddyplug/caddyplug 

FROM golang:alpine

RUN apk add --no-cache openssh-client git

MAINTAINER Huadong Zuo <admin@zuohuadong.cn>

ARG plugins="git"

COPY --from=builder /go/bin/caddyplug /usr/bin/caddyplug

# COPY --from=builder /usr/bin/caddy /usr/bin/caddy

## If you come frome china, please ues it.

# RUN echo "172.217.6.127 golang.org" >> /etc/hosts

RUN caddyplug install-caddy \
    && caddyplug install git
    
RUN caddy --version

EXPOSE 80 443 2015

WORKDIR /var/www/public

CMD ["/usr/bin/caddy", "-conf", "/etc/Caddyfile"]
