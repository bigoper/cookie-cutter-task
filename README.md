# docker-coockiecutter-python-flask-pgsql
Running a Flask app with pgsql on two docker containers
- ```docker-flask-simple-v1``` folder containing the web application (front-end)
- ```docker-pgsql-v1``` folder containing the database (postgresql)

## Tools
- We need to reverse engineer our existing database to generate the python models that SQLAlchemy can use.

    ```qlacodegen --outfile models.py postgres://globality:globality@127.0.0.1:5432/globality```

## Resources
- [docker-compose](https://docs.docker.com/compose)
- [docker pgsql](https://github.com/sameersbn/docker-postgresql)
- [docker pgsql hub](https://hub.docker.com/r/sameersbn/postgresql/)
- [docker commands](https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes)
- [dockerize postgresql](https://docs.docker.com/engine/examples/postgresql_service/#installing-postgresql-on-docker)

## General idea
We'll be running two docker containers, flask for the front-end and postgresql for the back-end.
The main (index) page will present data from the back-end, a list of members.

- we'll clone the git project, init 2 containers, import data and test :)

## Usage
- Start by cloning the git repository
- change into the project's root dir
- run ```docker-compose up```

## Test
- open your browser to `http://0.0.0.0:5000/` you'll see the index page and the data from the database.
