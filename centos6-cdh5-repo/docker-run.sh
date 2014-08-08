#!/bin/bash

CONTAINER_ID=$(docker run -d -i -t \
    --net=none \
    --name cdh5repo \
    --dns 10.0.10.1 \
    -h cdh5repo \
    "whlee21/centos6-cdh5-repo")

echo "Created container cdh5repo = ${CONTAINER_ID}"

sleep 1

IP_ADDR=$(dig +short cdh5repo A)

if [ ! "${IP_ADDR}" = "" ]; then
  sudo ./bin/pipework br1 ${CONTAINER_ID} "${IP_ADDR}/24@10.0.10.1"
  sudo ifconfig br1 10.0.10.1/24
else
  echo "IP address for cdh5repo NOT found."
fi
