include(utils.m4)dnl Include utility macros
_FEATURE_GUARD_

forInstall(luci-app,ahcp,firewall,minidlna,mjpg-streamer,statistics,rainbow,tinyproxy,transmission,upnp,wol)
forInstall(luci-proto,openconnect,relay,vpnc)
Install("luci-theme-bootstrap", { priority = 40 })

_LUCI_I18N_(ahcp, firewall, minidlna, statistics, tinyproxy, transmission, upnp, wol)

_END_FEATURE_GUARD_
