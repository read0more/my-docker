FROM nginx:stable-alpine

RUN set -x ; \
  addgroup -g 501 -S www-data ; \
  adduser -u 501 -D -S -G www-data www-data && exit 0 ; exit 1

