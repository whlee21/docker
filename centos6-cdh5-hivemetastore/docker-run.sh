#!/bin/bash

CONTAINER_ID=$(docker run -d -i -t \
    --name  "metastore" \
    --dns 172.17.42.1 --dns 168.126.63.1 --dns 168.126.63.2 \
    -h "metastore" \
    "whlee21/centos6-cdh5-hivemetastore")

echo "Created container [metastore] = ${CONTAINER_ID}"

#sleep 1

#IP_ADDR=$(dig +short metastore A)

#sudo ./bin/pipework br1 ${CONTAINER_ID} ${IP_ADDR}/24@10.0.10.1
