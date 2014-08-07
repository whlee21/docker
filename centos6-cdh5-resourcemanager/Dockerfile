FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum --disablerepo=epel --enablerepo=local-cdh5 install -y hadoop-yarn-resourcemanager hadoop-hdfs hadoop-mapreduce; yum clean all

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

ADD ./node-init.sh /usr/local/bin/node-init.sh
RUN chmod +x /usr/local/bin/node-init.sh

ADD ./run-yarn-examples.sh /root/run-yarn-examples.sh
RUN chmod +x /root/run-yarn-examples.sh

# for sshd
EXPOSE 22 8032 8030 8031 8033 8088

CMD node-init.sh && "/usr/bin/supervisord"
