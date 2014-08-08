#!/bin/bash

DATANODES="dn1 dn2 dn3"

for datanode in ${DATANODES}; do
  ssh root@${datanode} rm -rf /data/dfs/dn/current/*
done
