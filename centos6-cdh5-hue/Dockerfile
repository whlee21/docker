FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum --disablerepo=epel --enablerepo=local-cdh5 install -y hue hadoop-httpfs; yum clean all

ADD conf.hue /etc/hue/conf.docker
RUN alternatives --install /etc/hue/conf hue-conf /etc/hue/conf.docker 50
RUN alternatives --set hue-conf /etc/hue/conf.docker

ADD conf.hadoop-httpfs /etc/hadoop-httpfs/conf.docker
RUN alternatives --install /etc/hadoop-httpfs/conf hadoop-httpfs-conf /etc/hadoop-httpfs/conf.docker 50
RUN alternatives --set hadoop-httpfs-conf /etc/hadoop-httpfs/conf.docker

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

# for sshd
EXPOSE 22 8888

CMD ["/usr/bin/supervisord"]
