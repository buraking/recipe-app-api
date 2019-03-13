FROM python:3.7-alpine
MAINTAINER Søren Tekelioglu

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Make a workin env on a container set the defaultet working environment to /app
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Avoids running on root an limit the accessebility from a malicious attack
RUN adduser -D user
USER user