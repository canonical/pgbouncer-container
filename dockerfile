FROM ubuntu:20.04

RUN useradd -M pgbouncer && \
    apt-get -y update && \
    apt-get -y install pgbouncer && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /etc/pgbouncer
COPY ./pgbouncer.ini pgbouncer.ini
COPY ./userlist.txt userlist.txt
RUN chown -R pgbouncer: /etc/pgbouncer

USER pgbouncer

# TODO figure out how exposed port can be controlled from charm
EXPOSE 54321

ENTRYPOINT pgbouncer /etc/pgbouncer/pgbouncer.ini
