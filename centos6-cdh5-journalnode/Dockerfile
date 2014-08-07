FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum --disablerepo=epel --enablerepo=local-cdh5 install -y hadoop-hdfs-journalnode

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

# for sshd
EXPOSE 22 8485 8480

CMD chown -R hdfs:hdfs /data/dfs && "/usr/bin/supervisord"
