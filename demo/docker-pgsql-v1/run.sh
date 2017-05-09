#!/usr/bin/env bash

docker run --volume /Users/bigoper/GitHub/globality/docker-coockiecutter-python-flask-pgsql/docker-pgsql-v1:/var/lib/postgresql \
    --env 'DB_USER=globality' \
    --env 'DB_PASS=globality' \
    --env 'DB_NAME=globality' \
    --env 'PG_TRUST_LOCALNET=true' \
    --name pgsql \
    --net demo_network \
    --ip 172.72.72.10 \
    -itd \
    --restart always \
    -p 5432:5432 sameersbn/postgresql:9.6-2
