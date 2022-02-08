# PgBouncer Container

This docker image defines and configures the [PgBouncer connection pooler for PostgreSQL](https://www.pgbouncer.org), with a set of sensible defaults in pgbouncer.ini. These defaults are insecure, and should be modified to suit your needs, specifically in pgbouncer.ini and userlist.txt.

Built for use in the pgbouncer k8s charm: https://github.com/canonical/pgbouncer-k8s-operator

## Usage, and connecting to a postgres container

1. in one terminal, run the following:
    1. `docker pull postgres/postgres`
    1. `docker run --rm -P -e POSTGRES_PASSWORD=pw --name pg --hostname pg-host postgres`
1. in another terminal:
    1. `docker build -t pgbouncer:local .`
    1. `docker run -rm --name pgbouncer:local`
