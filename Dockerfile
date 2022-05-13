# Copyright 2022 Canonical Ltd.
# See LICENSE file for licensing details.
FROM ubuntu:20.04

RUN useradd -M pgbouncer && \
    apt-get -y update && \
    apt-get -y install pgbouncer=1.12.0-3 --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    chown -R postgres /etc/pgbouncer

USER pgbouncer

WORKDIR /etc/pgbouncer

COPY --chown=pgbouncer ./docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
