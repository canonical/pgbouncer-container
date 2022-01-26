FROM ubuntu:20.04

RUN useradd -M pgbouncer && \
    apt-get -y update && \
    apt-get -y install pgbouncer && \
    rm -rf /var/lib/apt/lists/* && \
    chown -R pgbouncer /etc/pgbouncer

USER pgbouncer

WORKDIR /etc/pgbouncer

COPY --chown=pgbouncer ./start_pgbouncer.sh start_pgbouncer.sh

# If not already set, set PGB_LISTEN_PORT to 6432
ENV PGB_LISTEN_PORT=${PGB_LISTEN_PORT:-6432}

# TODO figure out how exposed port can be controlled from charm
EXPOSE $PGB_LISTEN_PORT

ENTRYPOINT ["/bin/bash", "./start_pgbouncer.sh"]
