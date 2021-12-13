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

# TODO set port to an environment variable so it can be controlled from charm
EXPOSE 6432

# docs say to run this as daemon, but this way we can let a user choose whether they want logs .
# logs can also be found in /etc/pgbouncer/pgbouncer.log
ENTRYPOINT pgbouncer pgbouncer.ini
