FROM fedora:30

RUN dnf install -y bind iproute iputils bind-utils

RUN systemctl enable named

#ENV WILDCARD_DNS='first-domain.com=192.168.2.8,second-domain.com=192.168.2.16,tom.first-domain.com=192.168.2.10,jerry.second-domain.com=192.168.2.18'
#ENV DNSSEC_VALIDATE="auto"

ADD images/dns/bootstrap.sh /usr/bin/bootstrap
ADD images/dns/bootstrap.service /etc/systemd/system/bootstrap.service

RUN systemctl enable bootstrap;

COPY /images/dns/configs/bind/zones/* /etc/named/
COPY /images/dns/configs/bind/named.conf /etc/named.conf

RUN chown root:named /etc/named.conf

ENTRYPOINT [ "/sbin/init" ]
