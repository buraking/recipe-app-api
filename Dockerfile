FROM python:3.7-alpine
MAINTAINER Søren Tekelioglu

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build.deps \
    gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build.deps
# Make a workin env on a container set the defaultet working environment to /app
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Avoids running on root an limit the accessebility from a malicious attack
RUN adduser -D user
USER user