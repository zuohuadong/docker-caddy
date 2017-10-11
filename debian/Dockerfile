FROM golang

ARG plugins ="git"

# If you come frome china, please use it.
# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN go get github.com/abiosoft/caddyplug/caddyplug \
    && caddyplug install-caddy \
    && caddyplug install ${plugins}

EXPOSE 80 443 2015

WORKDIR /var/www/public

CMD ["/usr/bin/caddy", "-conf", "/etc/Caddyfile"]