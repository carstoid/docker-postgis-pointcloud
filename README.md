# PostGIS w. PointCloud Extension Docker Image
Repo containing the code for a Docker image containing PostGIS (2.4) and PointCloud (1.2.0), based on PostgreSQL 9.6, forked from bobleujr/docker-postgis-pointcloud.

## Build & Run
```
$ docker build --tag=pgpc .
$ docker run --name "pgpc_container_name" -e POSTGRES_USER=carsten -e POSTGRES_PASS=1234 -e POSTGRES_DBNAME=postgis -p 25432:5432 -t pgpc
```
Once the container is up and running, connect to the database and run `CREATE EXTENSION pointcloud;`. This will activate the pointcloud extension.

You can then access the database with QGIS, Grasshopper, PDAL, Blender scripts etc. using the credentials provided above.

This fork fixes a bug in the original repo where the container would crash on restart.
