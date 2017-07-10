FROM node:6.9.1-alpine
MAINTAINER mist.io <support@mist.io>

RUN apk add --update --no-cache git nginx

RUN npm install -g polymer-cli bower

ENV bower_allow_root=true \
    bower_interactive= \
    GIT_DIR=

COPY bower.json /elements/bower.json

WORKDIR /elements

RUN bower install

COPY . /elements

RUN node --max_old_space_size=4096 /usr/local/bin/polymer build

COPY ./container/nginx.conf /etc/nginx/nginx.conf

COPY ./container/entry.sh /entry.sh

EXPOSE 80
