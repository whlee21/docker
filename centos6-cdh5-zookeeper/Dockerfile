FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

ADD local-cdh5.repo /etc/yum.repos.d/local-cdh5.repo

RUN yum --disablerepo=cloudera-cdh5 --disablerepo=epel --enablerepo=local-cdh5 install -y zookeeper-server

# Zookeeper dir
RUN mkdir -p /var/lib/zookeeper
RUN echo "1" > /var/lib/zookeeper/myid
RUN chown zookeeper:zookeeper /var/lib/zookeeper/myid
RUN cat /var/lib/zookeeper/myid

RUN mv -f /etc/zookeeper/conf/zoo.cfg /etc/zookeeper/conf/zoo.cfg.org
ADD ./zoo.cfg /etc/zookeeper/conf/
RUN mkdir -p /var/lib/zookeeper
RUN chown -R zookeeper /var/lib/zookeeper/
RUN service zookeeper-server init

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

# for sshd, zookeeper
EXPOSE 22 2181 2888 3888

CMD echo "${ZOO_NODE_NUM}" > /var/lib/zookeeper/myid && "/usr/bin/supervisord"
