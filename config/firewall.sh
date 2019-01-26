#!/bin/sh
#
# This script will be run by OpenVPN on startup via the 'up' configuration
# directive in /etc/openvpn/server.conf.
#

echo "nameserver 8.8.8.8" >> /etc/resolv.conf

# Clear rules
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

default_interface = "$(route | grep '^default' | grep -o '[^ ]*$')"

# Set up iptables NAT rules as needed.
# Regular openvpn

/sbin/iptables -t nat -A POSTROUTING -s 10.77.2.0/255.255.255.0 -o $default_interface -j MASQUERADE

# I2P
d = "$(ifconfig tun0 | grep 'inet addr:' | grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1 }')"
/sbin/iptables -t nat -A PREROUTING -d $d -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 8118
/sbin/iptables -t nat -A PREROUTING -p udp -m udp --dport 1194 -j REDIRECT --to-ports 443
/sbin/iptables -A INPUT -p tcp -m tcp --dport 8118 -j DROP

# allow dns only for vpn network and localhost
/sbin/iptables -A INPUT -s 10.77.2.0/24 -p tcp -m tcp --dport 53 -j ACCEPT
/sbin/iptables -A INPUT -s 10.77.2.0/24 -p udp -m udp --dport 53 -j ACCEPT
/sbin/iptables -A INPUT -s 127.0.0.1 -p udp -m udp --dport 53 -j ACCEPT
/sbin/iptables -A INPUT -s 127.0.0.1 -p tcp -m tcp --dport 53 -j ACCEPT
/sbin/iptables -A INPUT -p udp -m udp --dport 53 -j DROP
/sbin/iptables -A INPUT -p tcp -m tcp --dport 53 -j DROP
/sbin/iptables -A INPUT ! -s 127.0.0.1 -p tcp -m tcp --dport 9050 -j DROP
