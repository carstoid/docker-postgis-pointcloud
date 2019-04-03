# [Docker PostGIS](https://github.com/kartoza/docker-postgis) + [PointCloud](https://github.com/pgpointcloud/pointcloud)

Repo containing the code for a Docker image containing PostGIS (2.4) and PointCloud (1.2.0), based on PostgreSQL 9.6.

## How to run

```
docker pull bobleujr/pointcloudpostgis
```

To build the image yourself without apt-cacher (also consumes more bandwidth
since deb packages need to be refetched each time you build) do:

```
docker build -t your_image_name git://github.com/bobleujr/docker-postgis-pointcloud
```

To create a running container do:

```
docker run --name container_name -p 25432:5432 -d -t bobleujr/pointcloudpostgis
```

## Environment variables

You can also use the following environment variables to pass a
user name, password and/or default database name.

* -e POSTGRES_USER=<PGUSER>
* -e POSTGRES_PASS=<PGPASSWORD>
* -e POSTGRES_DBNAME=<PGDBNAME>


## Debugging Notes
- able to build `$ docker build` (takes about ~5min)
- able to run (the first time) `$ docker run --name "pgpctest1" -e POSTGRES_USER=carsten -e POSTGRES_PASS=1234 -e POSTGRES_DBNAME=postgis -p 25432:5432 -t pgpointcloudtest` either with or without -d tag, runs headless if so

### Problem:
- able to connect to and use via QGIS with the credentials specified in the run command. importing a geojson file into the database via QGIS Database Manager is successful
- on `docker start pgpctest1`, crashes with "mkdir: cannot create directory 'pointcloud': File exists" (visible through `docker logs pgpctest1`)

### Tried:
- read:
  - https://docs.docker.com/storage/volumes/
  - https://docs.docker.com/storage/volumes/#populate-a-volume-using-a-container
  - https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes
- look for instances of mkdir in source code, make sure -p flag is set, then build again and test.
