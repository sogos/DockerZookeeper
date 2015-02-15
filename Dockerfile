# Dockerfile for zookeeper
# Version 3.4.6

FROM debian:wheezy

MAINTAINER Thibault Cordier

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && apt-get -qqy upgrade && apt-get -qqy install --no-install-recommends curl bash supervisor procps sudo ca-certificates openjdk-7-jre-headless openssh-client mysql-client pwgen && apt-get clean

ADD http://wwwftp.ciril.fr/pub/apache/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz /tmp/zookeeper-3.4.6.tar.gz
RUN mkdir -p /opt/zookeeper
RUN cd /opt/zookeeper && tar -xvf /tmp/zookeeper-3.4.6.tar.gz --strip 1
RUN rm -f /tmp/zookeeper-3.4.6.tar.gz
ADD zoo.cfg /opt/zookeeper/conf/zoo.cfg
ADD run.sh /opt/run
RUN chmod +x /opt/run

VOLUME  ["/var/lib/zookeeper"]

# Start Supervisor
ENTRYPOINT ["/opt/run", "/bin/bash"]

