#!/usr/bin/bash

ip addr flush dev eth0
ip address add 192.168.2.18/29 dev eth0
ip route add 0.0.0.0/0 via 192.168.2.17
echo "nameserver 192.168.2.2" > /etc/resolv.conf
