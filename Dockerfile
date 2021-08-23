FROM debian:bullseye-slim@sha256:dacf278785a4daa9de07596ec739dbc07131e189942772210709c5c0777e8437

# github metadata
LABEL org.opencontainers.image.source=https://github.com/uwcip/infrastructure-bind

# install updates and dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends tini bind9 bind9-dnsutils prometheus-bind-exporter && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
COPY named.conf.local /etc/bind/named.conf.local
COPY named.conf.options /etc/bind/named.conf.options

ENTRYPOINT ["/usr/sbin/named", "-f", "-4"]
