# Configuration for DNS filtering server
All is tested on **Ubuntu 22.04 LTS**

The architecture is next:
1) unbound is working on port `53`
2) unbound has persistent L2 cache which is represented by Redis
3) Redis is running on the same machine where Unbound
4) Nginx is listening for DoH requests on regular `443` port and proxy them to unbound port `53`

Pay attention, threads for unbound, workers for redis, instances for nginx are equals 4 = 2 core cpu with hyperthreading. If you have another number - you need to modify it.


Nginx is used as authorized proxy, it proxies DoH requests on `/dns-query/<client-id>`

Client-id should be some special uniqe combination, so DNS server is secured: direct requests to `/dns-query` are forbidden.

For sure, you can change it in `/etc/nginx/nginx.conf`



# unbound
We need unbound which is compiled locally, because standard package does not contain module `cachedb` which is needed to connect to Redis.
This is the full version print:
```
unbound -V
Version 1.19.0

Configure line: --with-libevent --with-libhiredis --with-libnghttp2 --disable-dependency-tracking --disable-flto --disable-maintainer-mode --disable-option-checking --disable-rpath --disable-silent-rules --enable-cachedb --enable-dnstap --enable-subnet --enable-systemd --enable-tfo-client --enable-tfo-server
Linked libs: libevent 2.1.12-stable (it uses epoll), OpenSSL 3.0.2 15 Mar 2022
Linked modules: dns64 cachedb subnetcache respip validator iterator
TCP Fastopen feature available

BSD licensed, see LICENSE in source package for details.
Report bugs to unbound-bugs@nlnetlabs.nl or https://github.com/NLnetLabs/unbound/issues
```
So, download Unbound 1.19.0 sources, unpack, `cd` inside extract and configure it: 

```sh
./configure --prefix=/usr --includedir=\${prefix}/include --infodir=\${prefix}/share/info --mandir=\${prefix}/share/man --localstatedir=/var --runstatedir=/run --sysconfdir=/etc --with-chroot-dir= --with-dnstap-socket-path=/run/dnstap.sock --with-libevent --with-libhiredis --with-libnghttp2 --with-pidfile=/run/unbound.pid --with-pythonmodule --with-pyunbound --disable-dependency-tracking --disable-flto --disable-maintainer-mode --disable-option-checking --disable-rpath --disable-silent-rules --enable-cachedb --enable-dnstap --enable-subnet --enable-systemd --enable-tfo-client --enable-tfo-server
```
Then:
```sh
make
make install
```

After installing unbound, setup unbound-control:


```sh
unbound-control-setup
```

Config is `/usr/local/etc/unbound/unbound.conf`

# Nginx
Again, we need to compile it from sources to add additinal needed modules linked statically.

So download **Nginx 1.25.3** and unpack it

Download `njs` sources and put them into `/etc/nginx/modules`.

Current configuration works for **njs version 0.8.2**

Compile it:
```sh
cd /etc/nginx/modules/njs
./configure
make
```

Compile and install nginx:
```sh
cd nginx-source
./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-g -O2 -ffile-prefix-map=/data/builder/debuild/nginx-1.24.0/debian/debuild-base/nginx-1.24.0=. -flto=auto -ffat-lto-objects -flto=auto -ffat-lto-objects -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' --with-ld-opt='-Wl,-Bsymbolic-functions -flto=auto -ffat-lto-objects -flto=auto -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie' --add-module=/etc/nginx/modules/njs/nginx
make
make install
```
You can replace `etc/nginx/nginx.conf` with one in this repo + put `doh-mappings.conf` to the same folder.
Also, you need to put `njs.d` inside `/etc/nginx`

# Update blocklists

Configuration for Unbound contains block lists.

With next steps you can create scheduled job to update them on regular basic.

Copy `/opt/unbound/` into yours  `/opt/unbound` then run next commands:

`chmod +x /opt/unbound/blocklists/update.sh`

Copy `unbound-blocklist-update.timer` and `unbound-blocklist-update.timer` to /etc/systemd/system


`systemctl enable unbound-blocklist-update.timer`
