include(utils.m4)dnl Include utility macros
dnl
Install foreach(PKG,`"luci-app-PKG" ',ahcp,firewall,minidlna,mjpg-streamer,statistics,tinyproxy,transmission,upnp,wol)
Install foreach(PKG,`"luci-proto-PKG" ',openconnect,relay,vpnc)
Install "luci-theme-bootstrap"

_LUCI_I18N_
for lang in pairs(luci_i18n) do
	for _, pkg in pairs({"ahcp", "firewall", "minidlna", "statistics", "tinyproxy", "transmission", "upnp", "wol"}) do
		Install("luci-i18n-" .. pkg .. "-" .. lang, { ignore = {"missing"} })
	end
end
