FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

ADD local-cdh5.repo /etc/yum.repos.d/local-cdh5.repo

RUN yum --disablerepo=cloudera-cdh5 --disablerepo=epel --enablerepo=local-cdh5 install -y hadoop-hdfs-namenode hadoop-hdfs-zkfc
#RUN yum install -y hadoop-hdfs-namenode hadoop-hdfs-zkfc

#ADD conf /etc/hadoop/conf.docker
#RUN alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.docker 50
#RUN alternatives --set hadoop-conf /etc/hadoop/conf.docker

ADD node-init.sh /usr/local/bin/node-init.sh

RUN chmod +x /usr/local/bin/node-init.sh

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

# for sshd
EXPOSE 22 8020 50070

CMD node-init.sh && "/usr/bin/supervisord"
