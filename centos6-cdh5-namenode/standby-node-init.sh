#!/bin/bash

chown -R hdfs:hdfs /data/dfs

yes "Y" | sudo -u hdfs hdfs namenode -bootstrapStandby

echo "[program:hadoop-hdfs-namenode]" >> /etc/supervisord.conf
echo "command=service hadoop-hdfs-namenode start" >> /etc/supervisord.conf
echo "" >> /etc/supervisord.conf
echo "[program:hadoop-hdfs-zkfc]" >> /etc/supervisord.conf
echo "command=service hadoop-hdfs-zkfc start" >> /etc/supervisord.conf

supervisorctl reload
