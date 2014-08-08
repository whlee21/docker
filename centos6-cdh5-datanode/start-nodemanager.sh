#!/bin/bash

DATANODES="dn1 dn2 dn3"

for datanode in ${DATANODES}; do
  ssh root@${datanode} service hadoop-yarn-nodemanager start
done
