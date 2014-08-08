#!/bin/bash

docker build --rm -t whlee21/centos6-cdh5-hiveserver2 `dirname $0`
docker images
