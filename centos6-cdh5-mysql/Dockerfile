FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum --disablerepo=epel --enablerepo=local-cdh5 install -y mysql-server; yum clean all

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

# for sshd
EXPOSE 22 60000 60010

CMD ["/usr/bin/supervisord"]
