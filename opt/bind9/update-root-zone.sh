#!/bin/bash
sudo wget -O /etc/bind/root.zone https://www.internic.net/domain/root.zone
rndc reload
