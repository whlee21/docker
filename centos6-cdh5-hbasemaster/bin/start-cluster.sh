#! /bin/bash

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
    -h "zoo${index}" \
    -e "ZOO_NODE_NUM=${index}" \
    -t "whlee21/centos6-cdh5-zookeeper")

  echo "Created container [zoo${index}] = ${CONTAINER_ID}"

  sleep 1

  sudo ./bin/pipework docker0 ${CONTAINER_ID} "172.17.0.${index}/16"

  echo "Started [zoo${index}] and assigned it the IP [10.0.10.${index}]"
  
#  if [ "$index" -eq "1" ] ; then
#    sudo ifconfig br1 10.0.10.254
#    #sudo ip addr add 10.0.10.254/24 dev br1
#    echo "Created interface for host"
#    sleep 1
#  fi
done

sleep 1

