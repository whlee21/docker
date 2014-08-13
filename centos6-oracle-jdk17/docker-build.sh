#!/bin/bash

docker build --rm -t whlee21/centos6-oracle-jdk17 `dirname $0`
docker images
