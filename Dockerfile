FROM golang:alpine

ARG version="0.10.9"

# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk update && apk add --no-cache --virtual .build-deps \
    build-base \
    && apk add --no-cache \
    openssh-client \
    git \
    && go get github.com/abiosoft/caddyplug/caddyplug \
    && caddyplug install-caddy \
    && caddyplug install git \
    && apk del .build-deps

EXPOSE 80 443 2015

WORKDIR /var/www/public

CMD ["/usr/bin/caddy", "-conf", "/etc/Caddyfile"]
# ENTRYPOINT ["/usr/bin/caddy"]
# CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]