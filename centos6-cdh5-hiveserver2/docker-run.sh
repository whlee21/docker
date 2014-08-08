#!/bin/bash

CONTAINER_ID=$(docker run -d -i -t \
    --name  "hiveserver2" \
    --dns 10.0.10.1 --dns 168.126.63.1 --dns 168.126.63.2 \
    -h "hiveserver2" \
    "whlee21/centos6-cdh5-hiveserver2")

echo "Created container [hiveserver2] = ${CONTAINER_ID}"

sleep 1

IP_ADDR=$(dig +short hiveserver2 A)

sudo ./bin/pipework br1 ${CONTAINER_ID} ${IP_ADDR}/24@10.0.10.1
