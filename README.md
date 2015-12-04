# docker-compose-CKAN
docker-compose-CKAN is an ephemeral docker-compose based setup of CKAN for development purposes, but can be used for other purposes also e.g demo purposes.

The docker-compose brings up the following components:
  - postgres
  - solr
  - redis
  - datapusher
  - CKAN

### HOW-TO
>Make sure to modify .env with all the CKAN configuration that you want to pass on to CKAN.
You need [docker] and [docker-compose] installed locally.

Starting docker-compose:
```sh
$ git submodule init
$ git submodule update
$ docker-compose up -d
```

>To open the docker-compose CKAN instance point your browser to http://localhost:8000

### Making Changes
To make changes modify the Dockerfile in the root of the repo and include your changes there, you can also add cron jobs in cron.d, and can utilize environment variables that are in the /srv/app/.env location of the ckan container. Refer to the docker-ckan-core and docker-ckan-cloud repos for more information.

To test your changes, run: 
```
$ docker-compose build
$ docker-compose restart
```

The docker-ckan-core is added as a git submodule for development purposes, so that changes to that repo can be tested locally.

### Deleting deployed containers
To delete deployed containers use the following commands:

```
$ docker-compose stop
$ docker-compose rm
```

   [docker-compose]: <https://docs.docker.com/compose/>
   [docker]: <https://www.docker.com/>
