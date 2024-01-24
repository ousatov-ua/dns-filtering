#!/bin/bash
for pid in $(ps -fe | grep 'kresd' | grep -v grep | awk '{print $2}'); do
        
        echo Renice Kresd process $pid
        renice -n -10 -p $pid
done

for pid in $(ps -fe | grep 'AdGuardHome' | grep -v grep | awk '{print $2}'); do
        echo Renice AdGuardHome $pid
        renice -n -10 -p $pid
done

ps -fl -C kresd
ps -fl -C AdGuardHome
