#!/bin/bash

docker build --rm -t whlee21/centos6-cdh5-resourcemanager `dirname $0`
docker images
