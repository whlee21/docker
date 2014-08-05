#!/bin/bash

chown -R hdfs:hdfs /data/dfs

#zkfc_initialized=$(/usr/lib/zookeeper/bin/zkCli.sh -server 10.0.10.1:2181 ls /hadoop-ha | grep docker)

#if [ "$zkfc_initialized" = "" ]; then
#  hdfs zkfc -formatZK
#fi

#hostname=$(hostname)

#if [ "$hostname" = "nn1" ]; then
#  if [ ! -f /data/dfs/nn/current/VERSION ]; then
#    yes "Y" | sudo -u hdfs hdfs namenode -format
#  fi
#elif [ "$hostname" = "nn2" ]; then
#  yes "Y" | sudo -u hdfs hdfs namenode -bootstrapStandby
#fi
