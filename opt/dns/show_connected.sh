#!/bin/bash
echo 'Total connections (from highest to lowest) - IP'
echo Port 443
netstat -tn 2>/dev/null | grep :443 | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head
echo Port 53
netstat -tn 2>/dev/null | grep :53 | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head
