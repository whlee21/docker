FROM centos:centos6

MAINTAINER Wanhee Lee <whlee21@gmail.com>

RUN yum install -y bzip2
RUN bzip2 /etc/yum.repos.d/CentOS-*.repo
ADD ./Daum.repo /etc/yum.repos.d/Daum.repo

# set timezone
RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/ROK /etc/localtime

RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

RUN yum --enablerepo=epel install -y python-meld3 python-setuptools acl alsa-lib at atk avahi-libs bc cairo cdparanoia-libs cups cups-libs cvs db4-cxx db4-devel dbus ed file fontconfig foomatic foomatic-db foomatic-db-filesystem foomatic-db-ppds freetype gdbm-devel gettext ghostscript ghostscript-fonts glibc-devel glibc-headers gnutls gstreamer gstreamer-plugins-base gstreamer-tools gtk2 hicolor-icon-theme iso-codes jasper-libs kernel-headers lcms-libs libICE libSM libX11 libX11-common libXau libXcomposite libXcursor libXdamage libXext libXfixes libXfont libXft libXi libXinerama libXrandr libXrender libXt libXtst libXv libXxf86vm libcap-ng libdrm libfontenc libgomp libgudev1 libjpeg-turbo libmng libogg liboil libpciaccess libpng libthai libtheora libtiff libudev libuser libvisual libvorbis libxcb m4 mailx man mesa-dri-drivers mesa-dri-filesystem mesa-dri1-drivers mesa-libGL mesa-libGLU mesa-private-llvm openjpeg-libs pango passwd patch pax perl-CGI perl-ExtUtils-MakeMaker perl-ExtUtils-ParseXS perl-Test-Harness perl-Test-Simple perl-devel phonon-backend-gstreamer pixman poppler poppler-data poppler-utils portreserve qt qt-sqlite qt-x11 qt3 redhat-lsb redhat-lsb-compat redhat-lsb-core redhat-lsb-graphics redhat-lsb-printing tar time tmpwatch urw-fonts xml-common xorg-x11-font-utils xz xz-lzma-compat wget unzip openssh-server openssh-clients rsyslog cronie-noanacron vim sudo apache-tomcat-apis axis bcel classpathx-jaf classpathx-mail flac geronimo-specs geronimo-specs-compat giflib jakarta-commons-discovery jakarta-commons-httpclient jakarta-commons-logging java-1.5.0-gcj java-1.7.0-openjdk java_cup jpackage-utils libart_lgpl libasyncns libgcj libsndfile log4j mx4j mysql-libs nc pulseaudio-libs regexp sinjdoc slf4j ttmkfdir tzdata-java wsdl4j xml-commons-apis xml-commons-resolver xorg-x11-fonts-Type1 zip; yum clean all

RUN rpm -Uvh ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/presbrey:/py/EL6/noarch/supervisor-3.0-13.1.noarch.rpm
RUN mv -f /etc/supervisord.conf /etc/supervisord.conf.org
ADD ./supervisord.conf /etc/

#RUN yum install -y wget unzip openssh-server openssh-clients rsyslog cronie-noanacron vim sudo; yum clean all

# install oracle-jdk-1.7
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.rpm" -O /opt/jdk-7u67-linux-x64.rpm
RUN rpm -Uvh /opt/jdk-7u67-linux-x64.rpm
RUN rm -f /opt/jdk-7u67-linux-x64.rpm

# install cloudera repository
#ADD cloudera-cdh-5-0.x86_64.rpm cloudera-cdh-5-0.x86_64.rpm
#RUN yum --nogpgcheck localinstall -y cloudera-cdh-5-0.x86_64.rpm
#RUN rpm --import http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera
#RUN rm -f cloudera-cdh-5-0.x86_64.rpm

RUN yum -y update; yum clean all

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

# writable hosts file
#RUN cp /etc/hosts /tmp/hosts
#RUN mkdir -p -- /lib-override && cp /lib64/libnss_files.so.2 /lib-override
#RUN perl -pi -e 's:/etc/hosts:/tmp/hosts:g' /lib-override/libnss_files.so.2
#ENV LD_LIBRARY_PATH /lib-override

# for sshd
EXPOSE 22

CMD ["/usr/bin/supervisord"]

# setup vim
RUN echo 'syntax on' >> /root/.vimrc
RUN echo 'alias vi="vim"' >> /root/.bashrc
