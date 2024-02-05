#!/bin/bash

curl -o "/opt/powerdns/blocklists/_hagezy-multi-normal.rpz" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/rpz/multi.txt"
curl -o "/opt/powerdns/blocklists/_hagezy-gambling.rpz" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/rpz/gambling.txt"
curl -o "/opt/powerdns/blocklists/_oisd-nsfw.rpz" "https://nsfw.oisd.nl/rpz"
curl -o "/opt/powerdns/blocklists/_hagezy-anti-privacy.rpz" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/rpz/anti.piracy.txt"
curl -o "/opt/powerdns/blocklists/_hagezy-no-safe-search.rpz" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/rpz/nosafesearch.txt"
curl -o "/opt/powerdns/blocklists/_hagezy-threat.rpz" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/rpz/tif.txt"
curl -o "/opt/powerdns/blocklists/_olus-blocklist.rpz" "https://raw.githubusercontent.com/ousatov-ua/dns-filtering/main/blocklist/olus-blocklist.rpz"

mv /opt/powerdns/blocklists/_hagezy-multi-normal.rpz /opt/powerdns/blocklists/hagezy-multi-normal.rpz
mv /opt/powerdns/blocklists/_hagezy-gambling.rpz /opt/powerdns/blocklists/hagezy-gambling.rpz
mv /opt/powerdns/blocklists/_oisd-nsfw.rpz /opt/powerdns/blocklists/oisd-nsfw.rpz
mv /opt/powerdns/blocklists/_hagezy-anti-privacy.rpz /opt/powerdns/blocklists/hagezy-anti-privacy.rpz
mv /opt/powerdns/blocklists/_hagezy-no-safe-search.rpz /opt/powerdns/blocklists/hagezy-no-safe-search.rpz
mv /opt/powerdns/blocklists/_hagezy-threat.rpz /opt/powerdns/blocklists/hagezy-threat.rpz
mv /opt/powerdns/blocklists/_olus-blocklist.rpz /opt/powerdns/blocklists/olus-blocklist.rpz

rec_control reload-lua-config /etc/powerdns/blocklists.lua
