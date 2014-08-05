#! /bin/bash

set -e

if sudo docker ps | grep "whlee21/centos6-cdh5-zookeeper" >/dev/null; then
  sudo docker ps | grep "whlee21/centos6-cdh5-zookeeper" | awk '{ print $1 }' | xargs -r sudo docker kill >/dev/null
  echo "Stopped the cluster and cleared all of the running containers."
fi
