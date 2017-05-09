#!/usr/bin/env bash

docker run -d -v /Users/bigoper/GitHub/globality/docker-coockiecutter-python-flask-pgsql/docker-flask-simple-v1:/app \
    --net demo_network \
    --ip 172.72.72.11 \
    -p 5000:5000 \
    --name dfsv1 docker-flask-simple-v1
