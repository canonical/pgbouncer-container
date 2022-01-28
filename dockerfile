FROM ubuntu:20.04

RUN useradd -M pgbouncer && \
    apt-get -y update && \
    apt-get -y install pgbouncer && \
    rm -rf /var/lib/apt/lists/* && \
    chown -R pgbouncer /etc/pgbouncer

USER pgbouncer

WORKDIR /etc/pgbouncer

COPY --chown=pgbouncer ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
