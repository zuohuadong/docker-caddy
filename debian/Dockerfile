FROM golang

ARG version="0.10.9"

# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apt update && apt install  \
    openssh-client \
    git \
    && go get github.com/abiosoft/caddyplug/caddyplug \
    && caddyplug install-caddy \
    && caddyplug install git

EXPOSE 80 443 2015

WORKDIR /var/www/public

CMD ["/usr/bin/caddy", "-conf", "/etc/Caddyfile"]