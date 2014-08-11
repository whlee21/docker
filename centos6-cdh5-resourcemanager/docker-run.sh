#!/bin/bash

set -e

if docker ps | grep "whlee21/centos6-cdh5-resourcemanager" >/dev/null; then
  echo ""
  echo "It looks like you already have some containers running."
  echo "Please take them down before attempting to bring up another"
  echo "cluster with the following command:"
  echo ""
  echo "  make stop-cluster"
  echo ""

  exit 1
fi

for index in `seq 1 2`;
do
  CONTAINER_ID=$(docker run -d -i -t \
    --name  "rm${index}" \
    --dns 172.17.42.1 --dns 168.126.63.1 --dns 168.126.63.2 \
    -h "rm${index}" \
    -v "/data/rm${index}/yarn/local:/data/yarn/local" \
    -v "/data/rm${index}/yarn/logs:/data/yarn/logs" \
    "whlee21/centos6-cdh5-resourcemanager")

  echo "Created container [rm${index}] = ${CONTAINER_ID}"

#  sleep 1

#  IP_ADDR=$(dig +short rm${index} A)

#  sudo ./bin/pipework br1 ${CONTAINER_ID} ${IP_ADDR}/24@10.0.10.1

#  echo "Started [nn${index}] and assigned it the IP [${IP_ADDR}]"
  
#  if [ "$index" -eq "1" ] ; then
#    sudo ifconfig br1 10.0.10.1/24
#    #sudo ip addr add 10.0.10.254/24 dev br1
#    echo "Created interface for host"
#    sleep 1
#  fi
done

sleep 1
