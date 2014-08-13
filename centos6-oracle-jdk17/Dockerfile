FROM centos:centos6

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum install -y wget

# install oracle-jdk-1.7
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.rpm" -O /opt/jdk-7u67-linux-x64.rpm
RUN rpm -Uvh /opt/jdk-7u67-linux-x64.rpm
RUN rm -f /opt/jdk-7u67-linux-x64.rpm
RUN alternatives --install /usr/bin/java java /usr/java/latest/jre/bin/java 200000
RUN alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000
RUN alternatives --install /usr/bin/jar jar /usr/java/latest/bin/jar 200000
