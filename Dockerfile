######################################install centos from base image ####################################
FROM centos:centos6
############################################################################################################

####################################### python2.7 installation ############################################
RUN yum -y groupinstall "Development tools"
RUN yum -y install zlib-devel \
    bzip2-devel \
        openssl-devel \
        ncurses-devel \
        sqlite-devel \
        readline-devel \
        tk-devel \
        gdbm-devel \
        db4-devel \
        libpcap-devel \
        xz-devel \
        python-libs.i686\
        wget
RUN echo "include ld.so.conf.d/*.conf" >> /etc/ld.so.conf
RUN echo "/usr/local/lib" >> /etc/ld.so.conf
RUN /sbin/ldconfig
RUN cd /tmp
RUN wget https://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz
RUN tar xf Python-2.7.6.tar.xz
RUN cd Python-2.7.6 &&  ./configure --prefix=/usr/local --enable-unicode=ucs4 --enable-shared
RUN cd Python-2.7.6 && make && make altinstall
RUN ldconfig
############################################ python2.7 installation END #####################################
############################################ mongodb installation START #####################################
RUN yum -y install epel-release.noarch \
    install mongodb-server.x86_64
############################################ mongodb installation END   #####################################
############################################ tomcat installation START  #####################################
RUN yum -y install java-1.8.0-openjdk.x86_64
RUN wget http://ftp.riken.jp/net/apache/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz
RUN tar xvzf apache-tomcat-7.0.73.tar.gz
RUN mv apache-tomcat-7.0.73  /usr/tomcat7
RUN useradd -M -d /usr/tomcat7 tomcat7
RUN chown -R tomcat7. /usr/tomcat7
ADD tomcat7 /etc/rc.d/init.d/tomcat7
RUN chmod 755 /etc/rc.d/init.d/tomcat7
RUN yum -y install elinks
EXPOSE 8080
CMD ["/usr/tomcat7/bin/catalina.sh","run"]
##############################################################################################################
