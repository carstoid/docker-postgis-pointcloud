# PostGIS w. PointCloud Extension Docker Image
Repo containing code for a Docker image containing PostGIS (2.4) and PointCloud (1.2.0), based on PostgreSQL 9.6, forked from bobleujr/docker-postgis-pointcloud.

## Build & Run

`$ docker build --tag=pgpc .`

`$ docker volume create gis_data` - disadvantage of this is that the volume is difficult to locate on the host

`$ docker run --name "pg" -v /mnt/NCP/docker-pg:/app -e POSTGRES_USER=carsten -e POSTGRES_PASS=1234 -e POSTGRES_DBNAME=postgis -p 25432:5432 -t pgpc`

Once the container is up and running, connect to the database and run:

```
CREATE EXTENSION pointcloud;
CREATE EXTENSION pointcloud_postgis;
```

This will activate the [pointcloud](https://github.com/pgpointcloud/pointcloud) extension and PostGIS integration.

You can then access the database with QGIS, Grasshopper, PDAL, Blender scripts etc. using the credentials provided above. To load data, use pdal from the command line or run a script using the python interface. A typical .laz file will take ~15mins. Then you'll want to create an index, like: `CREATE INDEX ON pc_northpuget2017 USING GIST(PC_EnvelopeGeometry(pa));` – this should take ~1min per .laz? Once the index is created adding to the db will index automatically.

This fork fixes a bug in the original repo where the container would crash on restart.
