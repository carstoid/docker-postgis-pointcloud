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
- able to run (the first time) `$ docker run --name "pgpctest1" -e POSTGRES_USER=carsten -e POSTGRES_PASS=1234 -e POSTGRES_DBNAME=postgis -p 25432:5432 -t pgpointcloud-test` either with or without -d tag, runs headless
- able to connect to and use via QGIS with the credentials specified in the run command. importing a geojson file into the database is successful
- but, on `docker start pgpctest1`, crashes with "mkdir: cannot create directory 'pointcloud': File exists" (visible through `docker logs pgpctest1`)
- look for instances of mkdir in source code
- read https://docs.docker.com/storage/volumes/
- try starting it with a volume: `$ docker run -v pgpctest3-data:/app --name "pgpctest3" -e POSTGRES_USER=carsten -e POSTGRES_PASS=1234 -e POSTGRES_DBNAME=postgis -p 25432:5432 -t pgpointcloud-test`
- this works, but probably not hooked up to the directories in the dockerfile...
- see https://docs.docker.com/storage/volumes/#populate-a-volume-using-a-container
- https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes
