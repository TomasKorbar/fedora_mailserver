FROM cytopia/bind:latest

RUN apt-get update
RUN apt-get --assume-yes install iproute2

ENV WILDCARD_DNS='first-domain.com=192.168.2.8,second-domain.com=192.168.2.16,tom.first-domain.com=192.168.2.10,jerry.second-domain.com=192.168.2.18'

ADD images/dns/bootstrap.sh /bootstrap.sh

ENTRYPOINT [ "/bootstrap.sh" ]
