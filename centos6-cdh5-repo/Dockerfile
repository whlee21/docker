FROM centos:centos6

MAINTAINER Wanhee Lee <whlee21@gmail.com>

# set timezone
RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/ROK /etc/localtime

RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum --enablerepo=epel install -y supervisor openssh-server yum-utils createrepo python-setuptools httpd; yum clean all
RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

# setup sshd
RUN echo 'root:root' | chpasswd
# no PAM
# http://stackoverflow.com/questions/18173889/cannot-access-centos-sshd-on-docker
RUN sed -i -e 's/^UsePAM yes/#UsePAM yes/' /etc/ssh/sshd_config
RUN sed -i -e 's/^#UsePAM no/UsePAM no/' /etc/ssh/sshd_config

# install cloudera repository
ADD cloudera-cdh-5-0.x86_64.rpm cloudera-cdh-5-0.x86_64.rpm
RUN yum --nogpgcheck localinstall -y cloudera-cdh-5-0.x86_64.rpm
RUN rpm --import http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera
RUN rm -f cloudera-cdh-5-0.x86_64.rpm

RUN mkdir -p /var/www/html/cdh/5
RUN reposync -r cloudera-cdh5 
RUN mv cloudera-cdh5/RPMS /var/www/html/cdh/5/
RUN cd /var/www/html/cdh/5/ && createrepo .

# for http
EXPOSE 22 80

CMD ["/usr/bin/supervisord"]
