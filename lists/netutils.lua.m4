include(utils.m4)dnl Include utility macros
dnl
-- Tools
Install "wol" "tcpdump"
Install "relayd" "udev"
Install "bind-client" "bind-dig"
Install "openvpn-openssl"

-- 3G
Install "br2684ctl" "comgt" "uqmi"
Install "ppp-mod-pppoa" "pptpd"
Install "usb-modeswitch" "usbutils"

-- IPv6
Install "ds-lite" "6in4" "6rd" "6to4"

-- Kernel
Install foreach(MOD,`"kmod-MOD" ',nf-nathelper-extra,usb-net-rndis,usb-net-qmi-wwan,usb-serial-option)

-- Luci
Install "luci-app-ddns" "luci-proto-3g"
_LUCI_I18N_
for lang in pairs(luci_i18n) do
	Install("luci-i18n-ddns-" .. lang, { ignore = {"missing"} })
end
