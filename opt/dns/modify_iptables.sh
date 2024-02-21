#!/bin/bash

#Specifically, many Linux distributions run with a connection tracking firewall configured. For high load operation (thousands of queries/second), 
#It is advised to either turn off iptables completely, or use the NOTRACK feature to make sure client DNS traffic bypasses the connection tracking.
iptables -t raw -I OUTPUT -p udp --sport 5653 -j CT --notrack
iptables -t raw -I PREROUTING -p udp --dport 5653 -j CT --notrack
iptables -I INPUT -p udp --dport 5653 -j ACCEPT

iptables -t raw -I OUTPUT -p tcp --sport 5653 -j CT --notrack
iptables -t raw -I PREROUTING -p tcp --dport 5653 -j CT --notrack
iptables -I INPUT -p tcp --dport 5653 -j ACCEPT

iptables -t raw -I OUTPUT -p udp --sport 443 -j CT --notrack
iptables -t raw -I PREROUTING -p udp --dport 443 -j CT --notrack
iptables -I INPUT -p udp --dport 443 -j ACCEPT

iptables -t raw -I OUTPUT -p tcp --sport 443 -j CT --notrack
iptables -t raw -I PREROUTING -p tcp --dport 443 -j CT --notrack
iptables -I INPUT -p tcp --dport 443 -j ACCEPT
