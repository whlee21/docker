#!/bin/bash

for index in `seq 1 1`;
do
  CONTAINER_ID=$(docker run -d -i -t \
    --name  "hm${index}" \
    --dns 172.17.42.1 --dns 168.126.63.1 --dns 168.126.63.2 \
    -h "hm${index}" \
    "whlee21/centos6-cdh5-hbasemaster")

  echo "Created container [hm${index}] = ${CONTAINER_ID}"
done
