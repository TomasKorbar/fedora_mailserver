FROM cytopia/bind:latest

RUN apt-get update
RUN apt-get --assume-yes install iproute2 procps openssh-server

ENV WILDCARD_DNS='first-domain.com=192.168.2.8,second-domain.com=192.168.2.16,tom.first-domain.com=192.168.2.10,jerry.second-domain.com=192.168.2.18'
ENV DNSSEC_VALIDATE="auto"

ADD images/dns/bootstrap.sh /bootstrap.sh

COPY ./images/server1/configs/opendkim/2019.txt /2019.txt.first
COPY ./images/server2/configs/opendkim/2019.txt /2019.txt.second

ENTRYPOINT [ "/bootstrap.sh" ]
