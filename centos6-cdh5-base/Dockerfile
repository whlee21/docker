FROM centos:centos6

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum install -y bzip2
RUN bzip2 /etc/yum.repos.d/CentOS-*.repo
ADD ./Daum.repo /etc/yum.repos.d/Daum.repo

# set timezone
RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/ROK /etc/localtime

RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

RUN yum --enablerepo=epel install -y python-meld3 python-setuptools

RUN rpm -Uvh ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/presbrey:/py/EL6/noarch/supervisor-3.0-13.1.noarch.rpm
RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

RUN yum install -y wget unzip openssh-server openssh-clients rsyslog cronie-noanacron vim sudo; yum clean all

# install oracle-jdk-1.7
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.rpm" -O /opt/jdk-7u67-linux-x64.rpm
RUN rpm -Uvh /opt/jdk-7u67-linux-x64.rpm
RUN rm -f /opt/jdk-7u67-linux-x64.rpm

# install cloudera repository
#ADD cloudera-cdh-5-0.x86_64.rpm cloudera-cdh-5-0.x86_64.rpm
#RUN yum --nogpgcheck localinstall -y cloudera-cdh-5-0.x86_64.rpm
#RUN rpm --import http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera
#RUN rm -f cloudera-cdh-5-0.x86_64.rpm
#RUN yum -y update; yum clean all

# install local cdh5 repository
ADD local-cdh5.repo /etc/yum.repos.d/local-cdh5.repo

# no PAM
RUN sed -i -e 's/^session\s\+required\s\+pam_loginuid\.so/#session required pam_loginuid.so/' /etc/pam.d/crond

# setup sshd
RUN echo 'root:root' | chpasswd
# no PAM
# http://stackoverflow.com/questions/18173889/cannot-access-centos-sshd-on-docker
RUN sed -i -e 's/^UsePAM yes/#UsePAM yes/' /etc/ssh/sshd_config
RUN sed -i -e 's/^#UsePAM no/UsePAM no/' /etc/ssh/sshd_config

ADD ./profile.d/hadoop.sh /etc/profile.d/hadoop.sh
ADD ./profile.d/jdk.sh /etc/profile.d/jdk.sh
ADD ./profile.d/oozie.sh /etc/profile.d/oozie.sh

ADD conf /etc/hadoop/conf.docker
RUN alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.docker 50
RUN alternatives --set hadoop-conf /etc/hadoop/conf.docker

ADD conf.hbase /etc/hbase/conf.docker
RUN alternatives --install /etc/hbase/conf hbase-conf /etc/hbase/conf.docker 50
RUN alternatives --set hbase-conf /etc/hbase/conf.docker

# for sshd
EXPOSE 22

CMD ["/usr/bin/supervisord"]

# setup vim
RUN echo 'syntax on' >> /root/.vimrc
RUN echo 'alias vi="vim"' >> /root/.bashrc
