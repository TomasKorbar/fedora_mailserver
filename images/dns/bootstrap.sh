#!/bin/bash

ip addr flush dev eth0
ip address add 192.168.2.2/29 dev eth0
ip route add 0.0.0.0/0 via 192.168.2.1

/docker-entrypoint.sh & sleep 5; \
cat /2019.txt.first >> /etc/bind/devilbox-wildcard_dns.first-domain.com.conf.zone;\
cat /2019.txt.second >> /etc/bind/devilbox-wildcard_dns.second-domain.com.conf.zone;\
echo "	IN	MX	0	tom.first-domain.com" >> /etc/bind/devilbox-wildcard_dns.first-domain.com.conf.zone;\
echo "	IN	MX	0	jerry.second-domain.com" >> /etc/bind/devilbox-wildcard_dns.second-domain.com.conf.zone;\

/bin/bash;
