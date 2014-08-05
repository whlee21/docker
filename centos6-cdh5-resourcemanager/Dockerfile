FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

ADD local-cdh5.repo /etc/yum.repos.d/local-cdh5.repo

RUN yum --disablerepo=cloudera-cdh5 --disablerepo=epel --enablerepo=local-cdh5 install -y hadoop-yarn-resourcemanager hadoop-hdfs hadoop-mapreduce; yum clean all

#ADD conf /etc/hadoop/conf.docker
#RUN alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.docker 50
#RUN alternatives --set hadoop-conf /etc/hadoop/conf.docker


RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

ADD ./node-init.sh /usr/local/bin/node-init.sh
RUN chmod +x /usr/local/bin/node-init.sh

ADD ./run-yarn-examples.sh /root/run-yarn-examples.sh
RUN chmod +x /root/run-yarn-examples.sh

# for sshd
EXPOSE 22 8032 8030 8031 8033 8088

CMD node-init.sh && "/usr/bin/supervisord"
