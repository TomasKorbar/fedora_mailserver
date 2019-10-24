#!/bin/bash

ip addr flush dev eth0
ip address add 192.168.2.2/29 dev eth0
ip route add 0.0.0.0/0 via 192.168.2.1

/bin/bash
