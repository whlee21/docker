FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum --disablerepo=epel --enablerepo=local-cdh5 install -y zookeeper-server

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

ADD ./node-init.sh /usr/local/bin/node-init.sh
RUN chmod +x /usr/local/bin/node-init.sh

# for sshd, zookeeper
EXPOSE 22 2181 2888 3888

CMD node-init.sh && "/usr/bin/supervisord"
