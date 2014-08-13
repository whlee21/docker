#!/bin/bash

CONTAINER_ID=$(docker run -d -i -t \
    --name hue \
    --dns 172.17.42.1 --dns 168.126.63.1 --dns 168.126.63.2 \
    -h hue \
    "whlee21/centos6-cdh5-hue")

echo "Created container hue = ${CONTAINER_ID}"
