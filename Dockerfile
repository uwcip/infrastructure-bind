FROM debian:bullseye-slim@sha256:5cf1d98cd0805951484f33b34c1ab25aac7007bb41c8b9901d97e4be3cf3ab04 AS base

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
