include(utils.m4)dnl Include utility macros
dnl
_FEATURE_GUARD_

forInstall(luci-app,ahcp,firewall,minidlna,mjpg-streamer,statistics,rainbow,tinyproxy,transmission,upnp,wol)
forInstall(luci-proto,openconnect,relay,vpnc)
Install("luci-theme-bootstrap")

_LUCI_I18N_(ahcp, firewall, minidlna, statistics, tinyproxy, transmission, upnp, wol)

_END_FEATURE_GUARD_
