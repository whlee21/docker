#!/bin/bash

CONTAINER_ID=$(docker run -d -i -t \
    --name dataworks \
    --dns 172.17.42.1 \
    -h dataworks \
    -p 9002:9000 \
    "whlee21/nable-dataworks")

echo "Created container dataworks = ${CONTAINER_ID}"
