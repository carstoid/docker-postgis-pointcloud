# PostGIS w. PointCloud Extension Docker Image

Repo containing code for a Docker image containing PostGIS (3) and PointCloud (1.2.1), based on PostgreSQL 11.

## Build & Run

`$ docker build --tag=pgpc .`  
`$ docker run -d --name "gisdata" -v volumename:/var/lib/postgresql -e POSTGRES_USER=your_username -e POSTGRES_PASS=your_password -e POSTGRES_DBNAME=gisdata -p 25432:5432 -t pgpc`

Once the container is up and running, connect to the database and run:

   - `CREATE EXTENSION pointcloud;`
   - `CREATE EXTENSION pointcloud_postgis;`

This will activate the [pointcloud](https://github.com/pgpointcloud/pointcloud) extension.

You can then access the database with QGIS, Grasshopper, PDAL, Blender scripts etc. using the credentials provided above. To load data, use pdal from the command line or run a script using the python interface. A typical .las file will take ~15mins. Then you'll want to create an index, like: `CREATE INDEX ON pc_northpuget2017 USING GIST(PC_EnvelopeGeometry(pa));` – this should take ~1min per .las? Once the index is created adding to the db will index automatically.

This fork fixes a bug in the original repo where the container would crash on restart, and provides the latest versions of PostGIS and PostgreSQL.
