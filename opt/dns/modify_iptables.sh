#!/bin/bash
iptables -t raw -I OUTPUT -p udp --sport 5353 -j CT --notrack
iptables -t raw -I PREROUTING -p udp --dport 5353 -j CT --notrack
iptables -I INPUT -p udp --dport 5353 -j ACCEPT

iptables -t raw -I OUTPUT -p tcp --sport 5353 -j CT --notrack
iptables -t raw -I PREROUTING -p tcp --dport 5353 -j CT --notrack
iptables -I INPUT -p tcp --dport 5353 -j ACCEPT

iptables -t raw -I OUTPUT -p udp --sport 443 -j CT --notrack
iptables -t raw -I PREROUTING -p udp --dport 443 -j CT --notrack
iptables -I INPUT -p udp --dport 5353 -j ACCEPT

iptables -t raw -I OUTPUT -p tcp --sport 443 -j CT --notrack
iptables -t raw -I PREROUTING -p tcp --dport 443 -j CT --notrack
iptables -I INPUT -p tcp --dport 5353 -j ACCEPT
