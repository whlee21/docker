FROM centos:centos6

MAINTAINER Wanhee Lee <whlee21@gmail.com>

# set timezone
RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/ROK /etc/localtime

RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum --enablerepo=epel install -y supervisor
RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

# install cloudera repository
ADD cloudera-cdh-5-0.x86_64.rpm cloudera-cdh-5-0.x86_64.rpm
RUN yum --nogpgcheck localinstall -y cloudera-cdh-5-0.x86_64.rpm
RUN rpm --import http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera
RUN rm -f cloudera-cdh-5-0.x86_64.rpm

RUN yum install -y yum-utils createrepo python-setuptools httpd; yum clean all

RUN mkdir -p /var/www/html/cdh/5

RUN reposync -r cloudera-cdh5 

RUN mv cloudera-cdh5/RPMS /var/www/html/cdh/5/

RUN cd /var/www/html/cdh/5/ && createrepo .

# for http
EXPOSE 80

CMD ["/usr/bin/supervisord"]
