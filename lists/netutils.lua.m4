include(utils.m4)dnl Include utility macros
dnl
_FEATURE_GUARD_

-- Tools
Install("wol", "tcpdump")
Install("relayd", "udev")
Install("bind-client", "bind-dig")
Install("openvpn-openssl")

-- 3G
Install("br2684ctl", "comgt", "uqmi")
Install("ppp-mod-pppoa", "pptpd")
Install("usb-modeswitch")

-- IPv6
Install("ds-lite", "6in4", "6rd", "6to4")

-- Kernel
forInstall(kmod,nf-nathelper-extra,usb-net-rndis,usb-net-qmi-wwan,usb-serial-option)

-- Luci
Install("luci-app-ddns", "luci-proto-3g")
_LUCI_I18N_(ddns)

_END_FEATURE_GUARD_
