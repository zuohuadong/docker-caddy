# FROM abiosoft/caddy

# MAINTAINER Huadong Zuo <admin@zuohuadong.cn>

# # ENV caddy_version=0.10.5
# ARG plugins=http.cors

# #LABEL caddy_version="$caddy_version" architecture="amd64"
# RUN /usr/bin/caddy -version
# RUN /usr/bin/caddy -plugins | grep http.cgi

# 

# CMD ["/usr/bin/caddy", "-conf", "/etc/Caddyfile"]
FROM golang:alpine
# FROM abiosoft/caddy:plugin

ARG version="0.10.9"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk update && apk add --no-cache openssh-client git build-base openssl
#RUN apt update && apt install git openssh-client -y

RUN go get github.com/abiosoft/caddyplug/caddyplug

RUN caddyplug install-caddy 
RUN caddyplug install git 

RUN apk del build-base

RUN caddy --version

# caddy
# RUN git clone https://github.com/mholt/caddy -b "v${version}" /go/src/github.com/mholt/caddy \
#     && cd /go/src/github.com/mholt/caddy \
#     && git checkout -b "v${version}"

# # # git plugin
# # RUN git clone https://github.com/abiosoft/caddy-git /go/src/github.com/abiosoft/caddy-git

# # # integrate git plugin
# # RUN printf 'package caddyhttp\nimport _ "github.com/abiosoft/caddy-git"' > \
# #     /go/src/github.com/mholt/caddy/caddyhttp/git.go


# builder dependency
# RUN git clone https://github.com/caddyserver/builds /go/src/github.com/caddyserver/builds

# # build
# RUN cd /go/src/github.com/mholt/caddy/caddy \
#     && git checkout -f \
#     && go run build.go \
#     && mv caddy /go/bin
# RUN caddyplug install-caddy
# RUN caddyplug install git
# #
# # Final stage
# #
# FROM alpine:3.6
# LABEL maintainer "Abiola Ibrahim <abiola89@gmail.com>"

# LABEL caddy_version="0.10.9"

# RUN apk add --no-cache openssh-client git

# # install caddy
# COPY --from=builder /go/bin/caddy /usr/bin/caddy
# COPY --from=builder /go/bin/caddyplug /usr/bin/caddyplug

# # validate install
# RUN /usr/bin/caddy -version
# RUN /usr/bin/caddy -plugins | grep http.git http.cors

EXPOSE 80 443 2015
# VOLUME /root/.caddy /srv
# WORKDIR /srv

# COPY Caddyfile /etc/Caddyfile
# COPY index.html /srv/index.html
WORKDIR /var/www/public

CMD ["/usr/bin/caddy", "-conf", "/etc/Caddyfile"]
# ENTRYPOINT ["/usr/bin/caddy"]
# CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]