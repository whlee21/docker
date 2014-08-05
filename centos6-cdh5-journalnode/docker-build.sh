#!/bin/bash

docker build --rm -t whlee21/centos6-cdh5-journalnode `dirname $0`
docker images
