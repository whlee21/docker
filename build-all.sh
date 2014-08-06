#!/bin/bash

IMAGES="centos6-cdh5-base centos6-cdh5-datanode centos6-cdh5-historyserver centos6-cdh5-journalnode centos6-cdh5-namenode centos6-cdh5-resourcemanager centos6-cdh5-zookeeper"

for image in $IMAGES; do
  $image/docker-build.sh
  if [ ! $? -eq 0 ]; then
    exit 1
  fi
done
