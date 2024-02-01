#!/bin/bash
tcpdump -n -i enp1s0 'tcp[tcpflags] & tcp-push != 0'
