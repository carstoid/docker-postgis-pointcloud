#!/usr/bin/env bash

echo "---begin pointcloud install---"
mkdir -p pointcloud
cd /pointcloud
chmod 700 /etc/postgresql/12/main/postgresql.conf
wget -O pointcloud.tar.gz "https://github.com/carstoid/pointcloud/archive/v1.2.1.tar.gz" \
   && apt-get update && apt-get -y install autoconf zlib1g-dev build-essential libpq-dev libxml2-dev postgresql-server-dev-12 \
   && mkdir -p /usr/src/pointcloud \
   && tar \
       --extract \
       --file pointcloud.tar.gz \
       --directory /usr/src/pointcloud \
       --strip-components 1 \
   && rm pointcloud.tar.gz \
   && cd /usr/src/pointcloud \
   && ./autogen.sh \
   && ./configure --with-pgconfig=/usr/bin/pg_config \
   && make \
   && make install

 cd /
