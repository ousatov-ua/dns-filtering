#!/bin/bash

curl -o "/opt/unbound/blocklists/hagezy-multi-normal.conf" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/unbound/multi.blacklist.conf"
curl -o "/opt/unbound/blocklists/hagezy-gambling.conf" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/unbound/gambling.blacklist.conf"
curl -o "/opt/unbound/blocklists/oisd-nsfw.conf" "https://nsfw.oisd.nl/unbound"
curl -o "/opt/unbound/blocklists/hagezy-anti-privacy.conf" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/unbound/anti.piracy.blacklist.conf"
curl -o "/opt/unbound/blocklists/hagezy-no-safe-search.conf" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/unbound/nosafesearch.blacklist.conf"
curl -o "/opt/unbound/blocklists/hagezy-threat.conf" "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/unbound/tif.blacklist.conf"
curl -o "/opt/unbound/blocklists/olus-filter.conf" "https://raw.githubusercontent.com/ousatov-ua/dns-filtering/main/blocklist/unbound-list.conf"
curl -o "/opt/unbound/blocklists/unbound-safe-search.conf" "https://raw.githubusercontent.com/ousatov-ua/dns-filtering/main/blocklist/unbound-safe-search.conf"

unbound-control reload_keep_cache
