#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM debian:stable
MAINTAINER Paulo Tabarro<paulogtabarro@gmail.com>

RUN apt -y update; apt -y install gnupg2 wget ca-certificates rpl pwgen
# RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

#-------------Application Specific Stuff ----------------------------------------------------

# We add postgis as well to prevent build errors (that we dont see on local builds)
# on docker hub e.g.
# The following packages have unmet dependencies:
RUN apt -y update; apt install -y postgresql-client-11 postgresql-common postgresql-11 postgresql-11-postgis-2.5 postgresql-11-pgrouting postgresql-11-postgis-2.5-scripts postgresql-server-dev-all netcat

# Open port 5432 so linked containers can see them
EXPOSE 5432

# We will run any commands in this when the container starts
ADD env-data.sh /
ADD docker-entrypoint.sh /
ADD setup-conf.sh /
ADD setup-database.sh /
ADD setup-pg_hba.sh /
ADD setup-replication.sh /
ADD setup-ssl.sh /
ADD setup-user.sh /
ADD setup-pointcloud.sh /
RUN chmod +x /*.sh


ENTRYPOINT /docker-entrypoint.sh
