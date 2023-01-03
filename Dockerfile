# Copyright 2022 Canonical Ltd.
# See LICENSE file for licensing details.
FROM ubuntu:22.04

RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC \
    apt-get -y install pgbouncer=1.16.1-1ubuntu1 pgbackrest=2.37-1 \
      --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /var/lib/postgresql/pgbouncer && \
    chown postgres /var/lib/postgresql/pgbouncer

# Installed with pgbouncer
USER postgres

WORKDIR /var/lib/postgresql/pgbouncer

COPY --chown=postgres ./docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
