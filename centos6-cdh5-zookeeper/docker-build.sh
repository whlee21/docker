#!/bin/bash

docker build --rm -t whlee21/centos6-cdh5-zookeeper `dirname $0`
docker images
