#!/bin/bash

set -e

if docker ps | grep "whlee21/centos6-cdh5-zookeeper" >/dev/null; then
  echo ""
  echo "It looks like you already have some containers running."
  echo "Please take them down before attempting to bring up another"
  echo "cluster with the following command:"
  echo ""
  echo "  make stop-cluster"
  echo ""

  exit 1
fi

for index in `seq 3`;
do
  CONTAINER_ID=$(docker run -d -i \
    --name  "zk${index}" \
    --dns 172.17.42.1 --dns 168.126.63.1 --dns 168.126.63.2 \
    -h "zk${index}" \
    -e "ZOO_NODE_NUM=${index}" \
    -t "whlee21/centos6-cdh5-zookeeper")

  echo "Created container [zk${index}] = ${CONTAINER_ID}"

#  sleep 1

#  IP_ADDR=$(dig +short zk${index} A)

#  sudo ./bin/pipework br1 ${CONTAINER_ID} ${IP_ADDR}/24@10.0.10.1

#  echo "Started [zk${index}] and assigned it the IP [${IP_ADDR}]"
  
#  if [ "$index" -eq "1" ] ; then
#    sudo ifconfig br1 10.0.10.1/24
#    #sudo ip addr add 10.0.10.254/24 dev br1
#    echo "Created interface for host"
#    sleep 1
#  fi
done

sleep 1
