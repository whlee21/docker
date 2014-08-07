FROM whlee21/centos6-cdh5-base

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum --disablerepo=epel --enablerepo=local-cdh5 install -y hadoop-hdfs-namenode hadoop-hdfs-zkfc

RUN useradd -m sshfence
RUN echo 'sshfence:sshfence123' | chpasswd

ADD node-init.sh /usr/local/bin/node-init.sh
RUN chmod +x /usr/local/bin/node-init.sh

ADD sshkey-gen.sh /home/sshfence/sshkey-gen.sh
RUN chmod +x /home/sshfence/sshkey-gen.sh

RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

# for sshd
EXPOSE 22 8020 50070

CMD node-init.sh && "/usr/bin/supervisord"
