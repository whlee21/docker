FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum --disablerepo=epel --enablerepo=local-cdh5 install -y  hadoop-yarn-nodemanager hadoop-hdfs-datanode hadoop-mapreduce hbase-regionserver

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

ENV LD_LIBRARY_PATH /lib-override

# for sshd
EXPOSE 22 50010 50075 50020 8040 8042 8041 23080 60020 60030
  
CMD chown -R hdfs:hdfs /data/dfs && chown -R yarn:yarn /data/yarn && "/usr/bin/supervisord"
