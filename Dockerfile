ARG BUILD_FROM
FROM $BUILD_FROM 

MAINTAINER Prentice Wongvibulsin <me@prenticew.com> 

ENV LANG C.UTF-8

RUN echo "http://dl-3.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk upgrade --update-cache --available && apk add keybase-client

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

