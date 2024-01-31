#!/bin/bash
for pid in $(ps -fe | grep 'kresd' | grep -v grep | awk '{print $2}'); do
	
	echo Renice Kresd process $pid
	renice -n -5 -p $pid
done

for pid in $(ps -fe | grep 'named' | grep -v grep | awk '{print $2}'); do
	
	echo Renice Bind9 process $pid
	renice -n -5 -p $pid
done

for pid in $(ps -fe | grep 'pdns_recursor' | grep -v grep | awk '{print $2}'); do
	
	echo Renice pdns_recursor process $pid
	renice -n -5 -p $pid
done

for pid in $(ps -fe | grep 'unbound' | grep -v grep | awk '{print $2}'); do
	
	echo Renice unbound process $pid
	renice -n -5 -p $pid
done

for pid in $(ps -fe | grep 'redis-server' | grep -v grep | awk '{print $2}'); do
	
	echo Renice redis-server process $pid
	renice -n -5 -p $pid
done

for pid in $(ps -fe | grep 'dnsdist' | grep -v grep | awk '{print $2}'); do
	
	echo Renice dnsdist process $pid
	renice -n -5 -p $pid
done

for pid in $(ps -fe | grep 'AdGuardHome' | grep -v grep | awk '{print $2}'); do
	echo Renice AdGuardHome $pid
	renice -n -5 -p $pid
done

echo 'knot-resolver:'
ps -fl -C kresd
echo 'named:'
ps -fl -C named
echo 'pdns_recursor:'
ps -fl -C pdns_recursor
echo 'unbound:'
ps -fl -C unbound
echo 'redis-server:'
ps -fl -C redis-server
echo 'dnsdist:'
ps -fl -C dnsdist
echo 'AdGuardHome:'
ps -fl -C AdGuardHome
