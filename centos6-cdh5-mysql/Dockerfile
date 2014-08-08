FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum --disablerepo=epel --enablerepo=local-cdh5 install -y mysql-server; yum clean all

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

ADD ./hive-init.sql /root/hive-init.sql
ADD ./hive-init.sh /root/hive-init.sh
RUN chmod +x /root/hive-init.sh

ADD ./install-mysql.sh /root/install-mysql.sh
RUN chmod +x /root/install-mysql.sh

# for sshd
EXPOSE 22 3306

CMD ["/usr/bin/supervisord"]
