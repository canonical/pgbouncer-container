# PgBouncer Container

This docker image defines and configures the [PgBouncer connection pooler for PostgreSQL](https://www.pgbouncer.org), with a set of sensible defaults in pgbouncer.ini. These defaults are insecure, and should be modified to suit your needs, specifically in pgbouncer.ini and userlist.txt.

Built for use in the pgbouncer k8s charm: https://github.com/canonical/pgbouncer-k8s-operator

## Usage, and connecting to a postgres container

1 in one terminal, run the following:
  1 `docker pull postgres/postgres`
  1 `docker run --rm -P -e POSTGRES_PASSWORD=pw --name pg --hostname pg-host postgres`
1 in another terminal:
  1 `docker build -t pgbouncer:local .`
  1 `docker run -rm --name pgbouncer:local`

### Environment variables

Pgbouncer won't run without the following environment variables passed in (no defaults are provided):

- `$PGB_DATABASES`
  - A string detailing the database config.
  - Schema available in the [pgbouncer documentation](https://www.pgbouncer.org/config.html#section-databases).
- `$PGB_LISTEN_PORT`
  - Port on which PgBouncer listens for traffic
- `$PGB_LISTEN_ADDR`
  - Address at which PgBouncer listens for traffic
- `$PGB_ADMIN_USERS`
  - Comma-separated list of admin users.
- `$PGB_ADMIN_PASSWORDS`
  - Comma-separated list of admin passwords, corresponding to `$PGB_ADMIN_USERS`
  - These will be encrypted in future.

