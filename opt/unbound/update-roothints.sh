#!/bin/bash
# wget ftp://FTP.INTERNIC.NET/domain/named.cache -O /usr/local/etc/unbound/root.hints
# IANA as source for root hints
wget ftp://rs.internic.net/domain/named.root -O /usr/local/etc/unbound/root.hints
# Generate root key
unbound-anchor -a "/usr/local/etc/unbound/root.key"
# Reload config
unbound-control reload_keep_cache
