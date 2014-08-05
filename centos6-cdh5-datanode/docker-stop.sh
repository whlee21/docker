#! /bin/bash

set -e

if sudo docker ps | grep "whlee21/centos6-cdh5-datanode" >/dev/null; then
  sudo docker ps | grep "whlee21/centos6-cdh5-datanode" | awk '{ print $1 }' | xargs -r sudo docker stop >/dev/null
  echo "Stopped the cluster and cleared all of the running containers."
fi
