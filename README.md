# Docker files for FIWARE Labs flavoured CKAN

[![Docker hub](https://img.shields.io/docker/pulls/fiware/ckan.svg)](https://hub.docker.com/r/fiware/ckan/)

[CKAN](https://github.com/ckan/ckan) is a powerful Data Management system used
to power Open Data catalogues across the world, including many national
portals. It has many publishing and curating features and offers a full API to
access both the metadata and certain data formats.

Full documentation for CKAN can be found at http://docs.ckan.org.

# How to use these Docker files

## Using Docker Compose (recommended)

This option requires [Docker Compose](https://docs.docker.com/compose/) to be
installed.

Docker Compose will take care of running and linking the following services:

* Postgres
* Solr
* Data contanier for file uploads
* DataPusher (see Know issues)
* CKAN itself


To run a CKAN instance with the FIWARE Labs extensions enabled, clone this
repository and run:

```
docker-compose up -d
```

After a few minutes you will be able to access the CKAN site at http://localhost:8000

![CKAN FIWARE](http://i.imgur.com/saUqbcp.png)

**NOTE:** the `oauth2` authorization extension is not enabled by default as it
requires further configuration. Edit the relevant settings on `setup/production.ini`.
You may need to set the `OAUTHLIB_INSECURE_TRANSPORT` env var if not serving CKAN under https,
check the [documentation](https://github.com/conwetlab/ckanext-oauth2/wiki/Activating-and-Installing) for details.

### Customizing the image

* CKAN configuration can be modified via the `setup/production.ini` file, which is
  mounted as a volume on the CKAN image. Check the documentation for all the
  available [configuration options](http://docs.ckan.org/en/latest/maintaining/configuration.html).

* Additional extensions can be easily installed editing the main `Dockerfile`.

* If you require changes to the Solr schema, these can be made to
  the `solr/ckan/conf/schema.xml` file, which is also mounted as a volume on
  the Solr image.


## Running the image directly

If you want to set up the Postgres and Solr servers separately you can run the
image directly with the following command:

```
docker run -p 8000:8000 -e CKAN_SQLALCHEMY_URL=postgresql://ckan_default:pass@localhost/ckan_default -e CKAN_SOLR_URL=http://localhost:8983 -e CKAN_SITE_URL=http://localhost:8000 fiware/ckan
```

You might want to use a `.env` file to define all your environment variables and pass that
as a parameter:

```
docker run -p 8000:8000 --env-file=.env fiware/ckan
```


# Known issues

* If you look at the log outputted when running `docker-compose up` you might see errors like
  these:

  ```
  postgres_1   | WARNING:  there is already a transaction in progress

  ckan_1       | IntegrityError: (IntegrityError) duplicate key value violates unique constraint "user_name_key"

  ```

  These are caused by the different services starting at the same time and can be safely ignored as the CKAN
  application will wait until the Postgres service is ready to start.

* Other messages that you might see are along these lines:

  ```
  WARNING: Service "ckan" is using volume "/srv/app/production.ini" from the previous container.
  ```

  This is an [issue](https://github.com/docker/compose/issues/2481) with Docker Compose which should be fixed
  on version 1.5.2.

* Datapusher won't work when running under Docker Compose because currently there is no support for
  biridectional container linking. This will be addressed on future Compose versions as part of
  changes in Networking support (see [this issue](https://github.com/docker/compose/pull/1676)
  for details).
