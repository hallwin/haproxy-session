FROM centos:latest
ADD . /HA
WORKDIR /HA
RUN cd /HA
RUN yum -y install gcc make
#RUN sysctl -w net.ipv4.ip_forward=1
RUN cd /HA/haproxy-1.6.3/ && make clean  && make TARGET=linux31 PREFIX=/application/haproxy && make PREFIX=/application/haproxy install
#RUN make TARGET=linux31 PREFIX=/application/haproxy 
#RUN make PREFIX=/application/haproxy install
RUN useradd haproxy -s /sbin/nologin
RUN cd /application/haproxy/ && mkdir -p bin conf logs var/run var/chroot
#RUN mkdir -p bin conf logs var/run var/chroot
RUN cp /HA/haproxy.cfg /application/haproxy/conf/haproxy.conf

EXPOSE 80

ENTRYPOINT /application/haproxy/sbin/haproxy -f /application/haproxy/conf/haproxy.conf

#CMD ["-f","/application/haproxy/conf/haproxy.conf"]
