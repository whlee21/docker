#!/bin/bash

sudo -u hdfs hadoop fs -copyFromLocal /etc/hadoop/conf/yarn-site.xml /user
sudo -u hdfs hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar  wordcount /user/yarn-site.xml /user/result
