#!/bin/bash

curl -o "/etc/bind/blocklists/hagezy-multi-normal.rpz" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/rpz/multi.txt"

curl -o "/etc/bind/blocklists/hagezy-gambling.rpz" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/rpz/gambling.txt"

curl -o "/etc/bind/blocklists/oisd-nsfw.rpz" "https://nsfw.oisd.nl/rpz"

curl -o "/etc/bind/blocklists/hagezy-anti-privacy.rpz" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/rpz/anti.piracy.txt"

curl -o "/etc/bind/blocklists/hagezy-no-safe-search.rpz" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/rpz/nosafesearch.txt"

curl -o "/etc/bind/blocklists/hagezy-threat.rpz" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/rpz/tif.txt"

curl -o "/etc/bind/blocklists/olus-blocklist.rpz" "https://raw.githubusercontent.com/ousatov-ua/dns-filters/main/rpz/olus.rpz"

rndc reload
