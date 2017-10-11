FROM golang

ARG plugins ="git"

RUN go get github.com/abiosoft/caddyplug/caddyplug \
    && caddyplug install-caddy \
    && caddyplug install ${plugins}

EXPOSE 80 443 2015

WORKDIR /var/www/public

CMD ["/usr/bin/caddy", "-conf", "/etc/Caddyfile"]