#!/bin/bash

CONF_URL="https://raw.githubusercontent.com/hagezi/dns-blocklists/main/unbound/multi.blacklist.conf"
LOCAL_FILE="/opt/unbound/blocklists/hagezy-multi-normal.conf"

curl -o "$LOCAL_FILE" "$CONF_URL"

CONF_URL="https://raw.githubusercontent.com/hagezi/dns-blocklists/main/unbound/gambling.blacklist.conf"
LOCAL_FILE="/opt/unbound/blocklists/hagezy-gambling.conf"

curl -o "$LOCAL_FILE" "$CONF_URL"

CONF_URL="https://nsfw.oisd.nl/unbound"
LOCAL_FILE="/opt/unbound/blocklists/oisd-nsfw.conf"

curl -o "$LOCAL_FILE" "$CONF_URL"

CONF_URL="https://raw.githubusercontent.com/hagezi/dns-blocklists/main/unbound/anti.piracy.blacklist.conf"
LOCAL_FILE="/opt/unbound/blocklists/hagezy-anti-privacy.conf"

curl -o "$LOCAL_FILE" "$CONF_URL"

CONF_URL="https://raw.githubusercontent.com/hagezi/dns-blocklists/main/unbound/nosafesearch.blacklist.conf"
LOCAL_FILE="/opt/unbound/blocklists/hagezy-no-safe-search.conf"

curl -o "$LOCAL_FILE" "$CONF_URL"

RPZ_URL="https://raw.githubusercontent.com/hagezi/dns-blocklists/main/unbound/tif.blacklist.conf"
LOCAL_FILE="/opt/unbound/blocklists/hagezy-threat.conf"

curl -o "$LOCAL_FILE" "$RPZ_URL"

CONF_URL="https://raw.githubusercontent.com/ousatov-ua/dns-filtering/main/blocklist/unbound-list.conf"
LOCAL_FILE="/opt/unbound/blocklists/olus-filter.conf"

curl -o "$LOCAL_FILE" "$CONF_URL"

RPZ_URL="https://raw.githubusercontent.com/ousatov-ua/dns-filtering/main/blocklist/unbound-safe-search.conf"
LOCAL_FILE="/opt/unbound/blocklists/unbound-safe-search.conf"

curl -o "$LOCAL_FILE" "$RPZ_URL"

unbound-control reload_keep_cache
