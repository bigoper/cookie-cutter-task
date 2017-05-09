# docker-coockiecutter-python-flask-pgsql
Running a Flask app with pgsql on two docker containers

##Tools
- We need to reverse engineer our existing database to generate the python models that SQLAlchemy can use.

    qlacodegen --outfile models.py postgres://globality:globality@127.0.0.1:5432/globality

##Pre-requisites
- local ```/Users/bigoper/srv/docker/``` folder (or any existing folder, with write permissions)


## Resources
- [docker-compose](https://docs.docker.com/compose)
- [Docker PGSql](https://github.com/sameersbn/docker-postgresql)

## Environment Requirements
Create two folders on the destination machine: (with write permissions)
- folder: /srv/docker/postgresql for the pgsql instance
- folder: /srv/docker/flask for the flask instance
- update the docker-compose file accordingly.
- docker network (for the containers and host to connect)
    create a new network ```docker network create -d bridge --subnet 10.0.1.0/24 --gateway 10.0.1.1 dockernet```
    make sure to replace the ```10.0.1.0``` network with your local network range.

## Usage
- clone the git project

###Database (new)
- clone the repository ```git clone https://github.com/bigoper/myflaskapp```
- CD to the project's root folder
- you can use the attached ```database/docker-compose.yml``` to setup the environment.
    - edit the ```volumes:``` section to match any existing\local folder path.
    - execute the database/docker-compose file, a docker instance will be executed (pgsql)

        docker-compose up &
        
- demo data: connect to the server and import resources/globality.sql.


### DATABASE (existing)
- make sure you have a PGSql database online and ready for connection.

## Flask App
once the DB is online and ready execute the following (or setup a docker container)
- clone the repository
- cd 
- ```pip install -r requirements.txt```
- ```bower install```
- ```flask run```
Now you can browse the app ```http://127.0.0.1```

