#!/bin/bash

CONTAINER_ID=$(docker run -d -i -t \
    --name db \
    --dns 172.17.42.1 --dns 168.126.63.1 --dns 168.126.63.2 \
    -h db \
    "whlee21/centos6-cdh5-mysql")

echo "Created container db = ${CONTAINER_ID}"

#sleep 1

#IP_ADDR=$(dig +short db.nablepjt.com A)

#sudo ./bin/pipework br1 ${CONTAINER_ID} ${IP_ADDR}/24@10.0.10.1
