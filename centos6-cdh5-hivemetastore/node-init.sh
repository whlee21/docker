#!/bin/bash

sudo -u hdfs hadoop fs -mkdir -p /user/hive/warehouse
sudo -u hdfs hadoop fs -chmod -R 1777 /user/hive/warehouse
