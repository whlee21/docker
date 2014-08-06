#!/bin/bash

set -e

if docker ps | grep "whlee21/centos6-cdh5-datanode" >/dev/null; then
  echo ""
  echo "It looks like you already have some containers running."
  echo "Please take them down before attempting to bring up another"
  echo "cluster with the following command:"
  echo ""
  echo "  make stop-cluster"
  echo ""

  exit 1
fi

for index in `seq 1 3`;
do
  CONTAINER_ID=$(docker run -d -i -t \
    --name  "dn${index}" \
    --dns 172.17.42.1 --dns 168.126.63.1 --dns 168.126.63.2 \
    -h "dn${index}" \
    -v "/data/dn${index}/dfs/dn:/data/dfs/dn" \
    -v "/data/dn${index}/yarn/local:/data/yarn/local" \
    -v "/data/dn${index}/yarn/logs:/data/yarn/logs" \
    "whlee21/centos6-cdh5-datanode")

  echo "Created container [dn${index}] = ${CONTAINER_ID}"

#  sleep 1

#  ip=$(expr ${index} + 11)

#  sudo ./bin/pipework br1 ${CONTAINER_ID} "10.0.10.${ip}/24@10.0.10.254"

#  echo "Started [nn${index}] and assigned it the IP [10.0.10.${ip}]"
  
#  if [ "$index" -eq "1" ] ; then
#    sudo ifconfig br1 10.0.10.254
#    #sudo ip addr add 10.0.10.254/24 dev br1
#    echo "Created interface for host"
#    sleep 1
#  fi
done

sleep 1
