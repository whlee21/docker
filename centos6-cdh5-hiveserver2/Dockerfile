FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum --disablerepo=epel --enablerepo=local-cdh5 install -y hive-server2; yum clean all

ADD ./conf /etc/hive/conf.docker
RUN alternatives --install /etc/hive/conf hive-conf /etc/hive/conf.docker 50
RUN alternatives --set hive-conf /etc/hive/conf.docker

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

# for sshd
EXPOSE 22

CMD ["/usr/bin/supervisord"]
