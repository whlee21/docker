#!/bin/bash

CONTAINER_ID=$(docker run -d -i -t \
    --name hs \
    --dns 172.17.42.1 --dns 168.126.63.1 --dns 168.126.63.2 \
    -h hs \
    -v "/data/hs/yarn/local:/data/yarn/local" \
    -v "/data/hs/yarn/logs:/data/yarn/logs" \
    "whlee21/centos6-cdh5-historyserver")

echo "Created container hs = ${CONTAINER_ID}"

#sleep 1

#IP_ADDR=$(dig +short hs.nablepjt.com A)

#sudo ./bin/pipework br1 ${CONTAINER_ID} ${IP_ADDR}/24@10.0.10.1
