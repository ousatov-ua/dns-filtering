# Prelude
If you don't have it on your machine by default:

```sh
apt install bash-completion
apt install rsyslog
```

Checkout out `.inputrc` in `/home/your_user` for autocomplete by a word previously typed


# Configuration for DNS filtering server
All is tested on **Ubuntu 22.04 LTS**

Repository contains different approaches:

-- Unbound + Redis + Nginx

-- Bind9 + RPZ + dnsdist

-- Knot-resolver + AdguardHome

-- Any variations: Unbound + Redis + AdguardHome, Bind9 + AdguardHome, Knot-resolver + AdguardHome...

## Unbound + Redis + Nginx

The architecture is next:
1) Unbound is working on port `53`
2) Unbound has persistent L2 cache which is represented by Redis
3) Redis is running on the same machine where Unbound
4) Nginx is listening for DoH requests on regular `443` port and proxy them to Unbound port `53`

Pay attention, threads for Unbound, workers for redis, instances for nginx are equals 4 = 2 core cpu with hyperthreading. If you have another number - you need to modify it.


Nginx is used as authorized proxy, it proxies DoH requests on `/dns-query/<client-id>`

Client-id should be some special uniqe combination, so DNS server is secured: direct requests to `/dns-query` are forbidden.

For sure, you can change it in `/etc/nginx/nginx.conf`



### Unbound
We need **Unbound Version 1.19.0** which is compiled locally, because standard package does not contain module `cachedb` which is needed to connect to Redis.
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

After installing Unbound, setup unbound-control:


```sh
unbound-control-setup
```

Config is `/usr/local/etc/unbound/unbound.conf`.

You may need to change user rights for `/usr/local/etc/unbound`: unbound has to have write permissions in case of using auto trust anchor file, for instance: `chown unbound:unbound /usr/local/etc/unbound`

Please pay attention that by default `Unbound` will use root hints to resolve DNS names: this approach gives the best privacy, security is based on DNSSEC.

If you want to use forwarders, please uncomment the appropriate section.

### Nginx
Again, we need to compile it from sources to add additinal needed modules linked statically.

So download **Nginx 1.25.3** and unpack it

Download `njs` https://nginx.org/en/docs/njs/install.html sources and put them into `/etc/nginx/modules`.

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

### Update blocklists and root hints

Configuration for Unbound contains block lists. For sure, you can edit them, I'm using my own configuration.

With next steps you can create scheduled job to update them on regular basis.

Copy `/opt/unbound/` into yours  `/opt/unbound` then run next commands:

```sh
chmod +x /opt/unbound/blocklists/update.sh
chmod +x /opt/unbound/update-roothints.sh
```


Copy files from `etc/systemd/system` to `/etc/systemd/system` and run next commands:

```sh
systemctl enable unbound-blocklist-update.timer
systemctl enable unbound-root-hints-update.timer
```
## Bind9 + RPZ + dnsdist

Documentation to be added.

## PowerDNS recursor + RPZ + dnsdist

NB: Seems like powerdns recursor needs much less memory comparing to BIND9. Also, rpz blocking rule works faster.

Documentation to be added.

## Knot-resolver6 + AdguardHome

Documentation to be added.
I followed steps from their howto to build it locally.
Next changes are needed in `sysctl.conf`:
```sh
vm.max_map_count=1099511627776
```
And I did local change for python script for manager (wait for up to 120 secs)

```sh
vim /usr/lib/python3/dist-packages/knot_resolver_manager/kresd_controller/supervisord/plugin/sd_notify.py
```
```py
if slf.state == ProcessStates.STARTING:
        if time.time() - slf.laststart > 120:
```
# Other stuff
There are some optimizations here:

`/etc/sysctl.conf`

I have disable IPv6 in `grub` too.
