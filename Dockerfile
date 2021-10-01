FROM debian:bullseye-slim@sha256:cdf2e66fbf065b0baad9798499c43ea91e01e11e5c970e8d0a60caf443d28727

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
