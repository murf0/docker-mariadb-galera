FROM phusion/baseimage:latest

MAINTAINER Mikael@murf.se

ENV HOME /root

COPY build.sh /build.sh
RUN chmod 755 /build.sh
RUN /build.sh

COPY setup.sh /setup.sh

# Add config(s) - standalone and cluster mode
ADD ./my.cnf /etc/mysql/my.cnf
#Setup startup

RUN mkdir /etc/service/mariadb
ADD mariadbgalera.sh /etc/service/mariadb/run
RUN chmod 755 /etc/service/mariadb/run

expose 3306 4567 4568 4444

CMD ["/sbin/my_init"]
