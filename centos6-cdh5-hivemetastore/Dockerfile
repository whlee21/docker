FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum --disablerepo=epel --enablerepo=local-cdh5 install -y hive-metastore mysql-connector-java mysql; yum clean all

RUN ln -s /usr/share/java/mysql-connector-java.jar /usr/lib/hive/lib/mysql-connector-java.jar

ADD ./profile.d/hive.sh /etc/profile.d/hive.sh

ADD ./conf /etc/hive/conf.docker
RUN alternatives --install /etc/hive/conf hive-conf /etc/hive/conf.docker 50
RUN alternatives --set hive-conf /etc/hive/conf.docker

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

ADD ./node-init.sh /usr/local/bin/node-init.sh
RUN chmod +x /usr/local/bin/node-init.sh

ADD ./init-schema.sh /root/init-schema.sh
RUN chmod +x /root/init-schema.sh

# for sshd
EXPOSE 22 60000 60010

CMD node-init.sh && /usr/bin/supervisord
