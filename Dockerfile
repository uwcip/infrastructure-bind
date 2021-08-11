FROM debian:bullseye-slim@sha256:9bfa0f4fb6d32116de4a6172f89a9266f7c73d1b8dae46f765bed703e541175e

# github metadata
LABEL org.opencontainers.image.source=https://github.com/uwcip/infrastructure-bind

# install updates and dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends tini bind9 bind9-dnsutils prometheus-bind-exporter && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
#COPY named.conf.local /etc/bind/named.conf.local
#COPY named.conf.options /etc/bind/named.conf.options

ENTRYPOINT ["/usr/sbin/named", "-f", "-4"]
