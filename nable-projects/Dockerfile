FROM whlee21/centos6-oracle-jdk17

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum install -y bzip2
RUN bzip2 /etc/yum.repos.d/CentOS-*.repo
ADD ./Daum.repo /etc/yum.repos.d/Daum.repo

# set timezone
RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/ROK /etc/localtime

RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum --enablerepo=epel install -y python-meld3 python-setuptools openssh-server wget unzip; yum clean all

# install supervisor
#RUN rpm -Uvh ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/presbrey:/py/EL6/noarch/supervisor-3.0-13.1.noarch.rpm
ADD ./supervisor-3.0-13.1.noarch.rpm /root/supervisor-3.0-13.1.noarch.rpm
RUN rpm -Uvh /root/supervisor-3.0-13.1.noarch.rpm
RUN rm -f /root/supervisor-3.0-13.1.noarch.rpm

# setup sshd
RUN echo 'root:root' | chpasswd

# no PAM
# http://stackoverflow.com/questions/18173889/cannot-access-centos-sshd-on-docker
RUN sed -i -e 's/^UsePAM yes/#UsePAM yes/' /etc/ssh/sshd_config
RUN sed -i -e 's/^#UsePAM no/UsePAM no/' /etc/ssh/sshd_config

ADD ./nablepjt-core-0.1.0 /opt/nablepjt-core-0.1.0
RUN ln -sf /opt/nablepjt-core-0.1.0 /opt/nablepjt-core
ADD ./nablepjt /etc/init.d/nablepjt

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

# for http
EXPOSE 22 9000

CMD ["/usr/bin/supervisord"]
