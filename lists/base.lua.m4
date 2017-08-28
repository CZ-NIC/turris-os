include(utils.m4)dnl Include utility macros
dnl
pushdef(`SUBDIRS',``subdirs = {"base", "turrispackages", "php", "hardware", "lucics", "packages", "routing", "management", "telephony", "printing"}'')dnl
dnl
-- The basic repository
Repository("turris", "https://api.turris.cz/openwrt-repo/_BOARD_`'ifdef(`_BRANCH_',-_BRANCH_)/packages", {
	SUBDIRS
})
ifdef(`_BRANCH_FALLBACK_',
`-- The fallback repository
Repository("turris-fallback", "https://api.turris.cz/openwrt-repo/_BOARD_-_BRANCH_FALLBACK_/packages", {
	SUBDIRS,
	priority = 40,
	ignore = {"missing"}
})
')popdef(`SUBDIRS')
-- Updater itself
Install('updater-ng', 'userlists', { critical = true })
-- Updater before v59.0 has no support for replan as string and it would complain about it. This is helper function to overcome that.
local function replan_str(str, bl)
	return (features and features.replan_string and str or bl)
end
Package('updater-ng', { replan = replan_str('immediate', true) })
Package('l10n_supported', { replan = replan_str('finished', true) })
Package('nuci', { replan = replan_str('finished', false) })
-- Updater won't remove package before replanning so add dependency on empty opkg-trans package if we have installed version with those files (We would like to use version_match but this condition has the same effect because version_match was defined later than packages were merged.)
if not version_match then
	Package('updater-ng', { deps = 'opkg-trans' })
end


-- Critical minimum
Install("base-files", "busybox", { critical = true })
Package("kernel", { reboot = "delayed" })
forInstallCritical(kmod,file2args(kmod.list))
forInstallCritical(kmod,file2args(kmod-_BOARD_.list))
Install("fstools"ifelse(_BOARD_,omnia,`, "btrfs-progs"'), { critical = true })
if features and features.provides then
	Install("dns-resolver", { critical = true }) -- if we don't support Provides than updater would report that this package is missing
end

-- OpenWRT minimum
Install("procd", "ubus", "uci", "netifd", "firewall", "swconfig", { critical = true})
Install("ebtables", "odhcpd", "odhcp6c", "rpcd", "opkg")

-- Turris minimum
if features and features.provides then
	Install("dhcp-server", "dhcpv6-server", "syslog", "cron")
end
Install("vixie-cron", "syslog-ng3", "logrotate")
Install("dnsmasq", "ppp", "ppp-mod-pppoe")
ifelse(_BOARD_,omnia,`Install("knot-resolver"',`Install("unbound", "unbound-anchor"'), { critical = (not features or not features.provides) }) -- This should be critical only if we ignored dns-resolver

-- Certificates
Install("dnssec-rootkey", "cznic-cacert-bundle", "cznic-repo-keys", "cznic-repo-keys-test", { critical = true })
-- Note: We don't ensure safety of these CAs
Install("ca-certificates")

_FEATURE_GUARD_

-- Utility
Install("ip", "iptables", "ip6tables")
Install("shadow", "shadow-utils", "uboot-envtools", "i2c-tools")
Install("openssh-client", "openssh-client-utils", "openssh-moduli", "openssh-server", "openssh-sftp-client", "openssh-sftp-server", "openssl-util")
Install("bind-client", "bind-dig")
Install("pciutils", "usbutils", "lsof")

-- Turris utility
Install("user_notify", "oneshot", "libatsha204", "sfpswitch", ifelse(_BOARD_,omnia,"rainbow-omnia","rainbow"), "watchdog_adjust", "daemon-watchdog", "update_mac", "switch-branch")
ifelse(_BOARD_,omnia,Install("schnapps")
)dnl
Install("foris", "foris-diagnostics-plugin")
if for_l10n then
	for_l10n("foris-l10n-")
	for_l10n("foris-diagnostics-plugin-l10n-")
end
Install("nuci", "nuci-nethist")
Install("turris-version", "lighttpd-https-cert", "start-indicator")
Install("conntrack-tools")
Install("lighttpd-mod-setenv") -- Missing dependency of luci (setenv used in /etc/lighttpd/conf.d/luci.conf)

-- Wifi
Install("hostapd-common", "wireless-tools", "wpad", "iw", "iwinfo"ifelse(_BOARD_,omnia,`, "ath10k-firmware-qca988x"'))

-- Terminal tools
Install("bash", "coreutils", "diffutils", "htop", "curl", "vim-full", "terminfo", "psmisc")

-- Luci
Install("luci")
forInstall(luci,base,proto-ipv6,proto-ppp,app-commands)
_LUCI_I18N_(base, commands)

_END_FEATURE_GUARD_
