include(utils.m4)dnl Include utility macros
dnl
Install foreach(PKG,`"luci-app-PKG" ',ahcp,firewall,minidlna,mjpg-streamer,statistics,rainbow,tinyproxy,transmission,upnp,wol)
Install foreach(PKG,`"luci-proto-PKG" ',openconnect,relay,vpnc)
Install "luci-theme-bootstrap"

_LUCI_I18N_(ahcp, firewall, minidlna, statistics, tinyproxy, transmission, upnp, wol)
