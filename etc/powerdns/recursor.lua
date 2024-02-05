-- Debian default Lua configuration file for PowerDNS Recursor

-- Load DNSSEC root keys from dns-root-data package.
-- Note: If you provide your own Lua configuration file, consider
-- running rootkeys.lua too.
dofile("/usr/share/pdns-recursor/lua-config/rootkeys.lua")

-- Zone to Cache is a function to load a zone into the Recursor cache periodically
zoneToCache(".", "url", "https://www.internic.net/domain/root.zone", { refreshPeriod = 86400 })

dofile("/etc/powerdns/blocklists.lua")
