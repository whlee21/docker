FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum install -y yum-utils createrepo python-setuptools httpd; yum clean all

RUN mkdir -p /var/www/html/cdh/5

RUN reposync -r cloudera-cdh5 

RUN mv cloudera-cdh5/RPMS /var/www/html/cdh/5/

RUN cd /var/www/html/cdh/5/ && createrepo .

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

# for http
EXPOSE 80

CMD ["/usr/bin/supervisord"]
