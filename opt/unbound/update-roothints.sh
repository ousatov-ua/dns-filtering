#!/bin/bash
wget ftp://FTP.INTERNIC.NET/domain/named.cache -O /usr/local/etc/unbound/root.hints
unbound-control reload_keep_cache
