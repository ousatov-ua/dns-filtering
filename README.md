# dns-filtering
Some useful configuration to use unbound/nginx/redis

All is for Ubuntu 22.04

# unbound

Configure unbound with next command:

```sh
./configure --prefix=/usr --includedir=\${prefix}/include --infodir=\${prefix}/share/info --mandir=\${prefix}/share/man --localstatedir=/var --runstatedir=/run --sysconfdir=/etc --with-chroot-dir= --with-dnstap-socket-path=/run/dnstap.sock --with-libevent --with-libhiredis --with-libnghttp2 --with-pidfile=/run/unbound.pid --with-pythonmodule --with-pyunbound --disable-dependency-tracking --disable-flto --disable-maintainer-mode --disable-option-checking --disable-rpath --disable-silent-rules --enable-cachedb --enable-dnstap --enable-subnet --enable-systemd --enable-tfo-client --enable-tfo-server
```

After installing unbound, setup unbound-control:


```sh
unbound-control-setup
```


Config is `/usr/local/etc/unbound/unbound.conf`
# Update blocklists


`chmod +x /opt/unbound/blocklists/update.sh`


Copy `unbound-blocklist-update.timer` and `unbound-blocklist-update.timer` to /etc/systemd/system


`systemctl enable unbound-blocklist-update.timer`


`systemctl start unbound-blocklist-update.timer`

# Nginx

You can try to use nginx from apt repository, I think it is better to have it updatable, though compiled version **should** be better it terms of performance.
```sh
sudo apt install nginx
```
It may say that 'stream' is not supported.

For compiling nginx I used next parameters:

```sh
./configure --sbin-path=/usr/bin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-pcre --pid-path=/var/run/nginx.pid --with-http_ssl_module --with-http_auth_request_module --modules-path=/etc/nginx/modules --with-http_v2_module  --with-stream
```

Also, you will need `nginx-module-njs`.

or
```sh
apt install nginx-module-njs
```

Copy njs.d to `/etc/nginx/njs.d`
