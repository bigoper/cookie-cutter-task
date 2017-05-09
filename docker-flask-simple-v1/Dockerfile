FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev && \
    apt-get install -y python-psycopg2 && \
    apt-get install -y curl

# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

CMD ["python", "/app/app.py"]
