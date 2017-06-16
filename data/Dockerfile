FROM debian:jessie

ENV CKAN_DATA_DIR /var/lib/ckan/default

RUN mkdir -p $CKAN_DATA_DIR && chown -R www-data:www-data $CKAN_DATA_DIR
VOLUME ["/var/lib/ckan/default"]
