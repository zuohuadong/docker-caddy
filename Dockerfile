#
# Builder
#
FROM abiosoft/caddy:builder as builder

ARG version="0.11.2"
ARG plugins="git,cors,realip,expires,cache,filter,cloudxns"

# process wrapper
RUN go get -v github.com/abiosoft/parent

RUN VERSION=${version} PLUGINS=${plugins} /bin/sh /usr/bin/builder.sh

#
# Final stage
#
FROM alpine:3.10
LABEL maintainer "Abiola Ibrahim <abiola89@gmail.com>"

ARG version="0.11.2"
LABEL caddy_version="$version"

# Let's Encrypt Agreement
ENV ACME_AGREE="false"

RUN apk add --no-cache openssh-client git

# install caddy
COPY --from=builder /install/caddy /usr/bin/caddy

# validate install
RUN /usr/bin/caddy -version
RUN /usr/bin/caddy -plugins

EXPOSE 80 443 2015


WORKDIR /var/www


# install process wrapper
COPY --from=builder /go/bin/parent /bin/parent

ENTRYPOINT ["/bin/parent", "caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout", "--agree=$ACME_AGREE"]
