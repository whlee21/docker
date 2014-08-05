#!/bin/bash

CONTAINER_ID=$(docker run -d -i -t \
    --name cdh5repo \
    --dns 10.0.10.254 \
    -h cdh5repo \
    "whlee21/centos6-cdh5-repo")

echo "Created container cdh5repo = ${CONTAINER_ID}"

sleep 1

sudo ./bin/pipework br1 ${CONTAINER_ID} "10.0.10.253/24"
