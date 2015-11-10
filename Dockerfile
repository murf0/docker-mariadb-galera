FROM phusion/baseimage:latest

MAINTAINER Mikael@murf.se

ENV HOME /root

COPY build.sh /build.sh
RUN chmod 755 /build.sh
RUN /build.sh

COPY create_mariadb_admin_user.sh /create_mariadb_admin_user.sh
RUN chmod 755 /create_mariadb_admin_user.sh

COPY setup.sh /setup.sh
RUN chmod 755 /build.sh
RUN /build.sh

RUN mkdir /etc/service/mariadb
ADD mariadbgalera.sh /etc/service/mariadb/run
RUN chmod 755 /etc/service/mariadb/run

# Add config(s) - standalone and cluster mode
ADD ./my.cnf /etc/mysql/my.cnf

expose  3306

CMD ["/sbin/my_init"]