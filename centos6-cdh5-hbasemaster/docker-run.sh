#!/bin/bash

for index in `seq 1 1`;
do
  CONTAINER_ID=$(docker run -d -i -t \
    --name  "hm${index}" \
    --dns 10.0.10.1 --dns 168.126.63.1 --dns 168.126.63.2 \
    -h "hm${index}" \
    "whlee21/centos6-cdh5-hbasemaster")

  echo "Created container [hm${index}] = ${CONTAINER_ID}"

  sleep 1

  IP_ADDR=$(dig +short hm${index} A)

  sudo ./bin/pipework br1 ${CONTAINER_ID} ${IP_ADDR}/24@10.0.10.1

  echo "Started [hm${index}] and assigned it the IP [${IP_ADDR}]"
  
  if [ "$index" -eq "1" ] ; then
    sudo ifconfig br1 10.0.10.1/24
    #sudo ip addr add 10.0.10.254/24 dev br1
    echo "Created interface for host"
    sleep 1
  fi
done
