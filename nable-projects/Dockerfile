FROM centos:centos6

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum install -y bzip2
RUN bzip2 /etc/yum.repos.d/CentOS-*.repo
ADD ./Daum.repo /etc/yum.repos.d/Daum.repo

# set timezone
RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/ROK /etc/localtime

RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum --enablerepo=epel install -y python-meld3 python-setuptools openssh-server wget; yum clean all

# install supervisor
#RUN rpm -Uvh ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/presbrey:/py/EL6/noarch/supervisor-3.0-13.1.noarch.rpm
ADD ./supervisor-3.0-13.1.noarch.rpm /root/supervisor-3.0-13.1.noarch.rpm
RUN rpm -Uvh /root/supervisor-3.0-13.1.noarch.rpm
RUN rm -f /root/supervisor-3.0-13.1.noarch.rpm

# install oracle-jdk-1.7
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.rpm" -O /opt/jdk-7u67-linux-x64.rpm
RUN rpm -Uvh /opt/jdk-7u67-linux-x64.rpm
RUN rm -f /opt/jdk-7u67-linux-x64.rpm
RUN alternatives --install /usr/bin/java java /usr/java/latest/jre/bin/java 200000
RUN alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000
RUN alternatives --install /usr/bin/jar jar /usr/java/latest/bin/jar 200000

# setup sshd
RUN echo 'root:root' | chpasswd

# no PAM
# http://stackoverflow.com/questions/18173889/cannot-access-centos-sshd-on-docker
RUN sed -i -e 's/^UsePAM yes/#UsePAM yes/' /etc/ssh/sshd_config
RUN sed -i -e 's/^#UsePAM no/UsePAM no/' /etc/ssh/sshd_config

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

# for http
EXPOSE 22 80

CMD ["/usr/bin/supervisord"]
