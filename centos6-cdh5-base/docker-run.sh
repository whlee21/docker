#!/bin/bash

#docker run -d -i -t -p 2222:22 -v `dirname $0`:/mnt:rw whlee21/centos6-cdh5-base
docker run -h cdh5base -d -i -t -p 2222:22 whlee21/centos6-cdh5-base
docker ps

