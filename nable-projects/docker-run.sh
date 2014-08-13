#!/bin/bash

CONTAINER_ID=$(docker run -d -i -t \
    --name nablepjt \
    --dns 172.17.42.1 \
    -h nablepjt \
    -p 9000:9000 \
    "whlee21/nable-projects")

echo "Created container nablepjt = ${CONTAINER_ID}"
