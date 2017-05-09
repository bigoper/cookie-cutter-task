# docker-coockiecutter-python-flask-pgsql
Running a Flask app with pgsql on two docker containers
- ```docker-flask-simple-v1``` folder containing the web application (front-end)
- ```docker-pgsql``` folder containing the database (postgresql)

## Tools
- We need to reverse engineer our existing database to generate the python models that SQLAlchemy can use.

    qlacodegen --outfile models.py postgres://globality:globality@127.0.0.1:5432/globality


## Resources
- [docker-compose](https://docs.docker.com/compose)
- [Docker PGSql](https://github.com/sameersbn/docker-postgresql)

## General idea
We'll be running two docker containers, flask for the front-end and postgresql for the back-end.
The main (index) page will present data from the back-end, a list of members.

- we'll clone the git project, init 2 containers, import data and test :)

## Usage
Start by cloning the git repository
- ```git clone https://github.com/bigoper/docker-coockiecutter-python-flask-pgsql.git```

## Networking
We need to allow the 2 containers to communicate
- run the following commands to create a network to hold the containers.
- ```
    docker network create -d bridge --subnet 172.72.72.0/24 demo_network
    docker network inspect demo_network
    ```
- the last command will show you the network with the mentioned containers.
- update the front-end code to reflect the new ip address (to connect to the database)

### Database
- CD to the project's root folder.
- ```
    cd docker-pgsql-v1
    chmod +x *.sh
    ./clean-docker.sh   
    ./build.sh   
    ./run.sh
    ```
- database info
    - db_user: globality
    - db_pass: globality
    - db_name: globality
    - table: members
    - ip address: 172.72.72.10
- import demo data
    - ```cat globality.sql | docker exec -i pgsql psql -U globality```

###Web
- CD to the project's root folder.
- ```
    cd docker-flask-simple-v1
    chmod +x *.sh
    ./clean-docker.sh   
    ./build.sh   
    ./run.sh
    ```
>NOTE: now you have 2 running containers.

##Test
- open your browser to `http://0.0.0.0:5000/` you'll see the index page and the data from the database.
