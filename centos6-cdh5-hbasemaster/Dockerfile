FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum --disablerepo=epel --enablerepo=local-cdh5 install -y hbase hbase-master hadoop-hdfs; yum clean all

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

ADD ./node-init.sh /usr/local/bin/node-init.sh
RUN chmod +x /usr/local/bin/node-init.sh

# for sshd
EXPOSE 22 60000 60010

CMD node-init.sh && /usr/bin/supervisord
