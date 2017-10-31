include(utils.m4)dnl Include utility macros
include(repository.m4)dnl Include Repository command
-- Updater itself
Install('updater-ng', 'userlists', { critical = true })
--[[
Updater before v59.0 has no support for replan as string and it would complain
about it. This is helper function is here to overcome that.
]]
local function replan_str(str, bl)
	return (features and features.replan_string and str or bl)
end
Package('updater-ng', { replan = replan_str('immediate', true) })
Package('l10n_supported', { replan = replan_str('finished', true) })
Package('nuci', { replan = replan_str('finished', false) })


-- Critical minimum
Install("base-files", "busybox", { critical = true })
Package("kernel", { reboot = "delayed" })
Package("kmod-mac80211", { reboot = "delayed" })
forInstallCritical(kmod,file2args(kmod.list))
forInstallCritical(kmod,file2args(kmod-_BOARD_.list))
Install("fstools", { critical = true })
if board:match("[Oo]mnia") then
	Install("btrfs-progs", { critical = true })
end
if features and features.provides then
	-- If we don't support Provides than updater would report that this package is missing
	Install("dns-resolver", { critical = true })
end

-- OpenWRT minimum
Install("procd", "ubus", "uci", "netifd", "firewall", "swconfig", { critical = true})
Install("ebtables", "odhcpd", "odhcp6c", "rpcd", "opkg", { priority = 40 })

-- Turris minimum
if features and features.provides then
	Install("dhcp-server", "dhcpv6-server", "syslog", "cron", { priority = 40 })
end
Install("vixie-cron", "syslog-ng3", { priority = 40 })
Install("logrotate", { priority = 40 })
Install("dnsmasq", { priority = 40 })
-- Note: Following packages should be critical only if we ignored dns-resolver
if board:match("[Oo]mnia") then
	Install("knot-resolver", { critical = (not features or not features.provides), priority = 40 })
else
	Install("unbound", "unbound-anchor", { critical = (not features or not features.provides), priority = 40 })
end
Install("ppp", "ppp-mod-pppoe", { priority = 40 })

-- Certificates
Install("dnssec-rootkey", "cznic-cacert-bundle", "cznic-repo-keys", "cznic-repo-keys-test", { critical = true })
-- Note: We don't ensure safety of these CAs
Install("ca-certificates", { priority = 40 })

_FEATURE_GUARD_

-- Utility
Install("ip-full", "iptables", "ip6tables", { priority = 40 })
Install("shadow", "shadow-utils", "uboot-envtools", "i2c-tools", { priority = 40 })
Install("openssh-client", "openssh-client-utils", "openssh-moduli", "openssh-server", "openssh-sftp-client", "openssh-sftp-server", "openssl-util", { priority = 40 })
Install("bind-client", "bind-dig", { priority = 40 })
Install("pciutils", "usbutils", "lsof", { priority = 40 })

-- Turris utility
Install("user_notify", "oneshot", "libatsha204", "watchdog_adjust", "daemon-watchdog", "update_mac", "switch-branch", { priority = 40 })
if board:match("[Oo]mnia") then
	Install("rainbow-omnia", { priority = 40 })
	Install("schnapps", "sfpswitch", { priority = 40 })
else
	Install("rainbow", { priority - 40 })
end

Install("foris", "foris-diagnostics-plugin", { priority = 40 })
if for_l10n then
	for_l10n("foris-l10n-")
	for_l10n("foris-diagnostics-plugin-l10n-")
end
Install("nuci", "nuci-nethist", { priority = 40 })
Install("turris-version", "lighttpd-https-cert", "start-indicator", { priority = 40 })
Install("conntrack-tools", { priority = 40 })
Install("lighttpd-mod-setenv", { priority = 40 }) -- Missing dependency of luci (setenv used in /etc/lighttpd/conf.d/luci.conf)

-- Wifi
Install("hostapd-common", "wireless-tools", "wpad", "iw", "iwinfo", { priority = 40 })
if board:match("[Oo]mnia") then
	Install("ath10k-firmware-qca988x", { priority = 40 })
end

-- Terminal tools
Install("bash", "coreutils", "diffutils", "htop", "curl", "vim-full", "terminfo", "psmisc", { priority = 40 })

-- Luci
Install("luci", { priority = 40 })
forInstall(luci,base,proto-ipv6,proto-ppp,app-commands)
_LUCI_I18N_(base, commands)

_END_FEATURE_GUARD_

--[[
Not all version of updater supported all features and so we are collecting various
hacks so we would be able to update from older versions to new one.
]]

--[[
In Turris OS 3.8 files from original package opkg-trans were moved to mostly empty
package updater-ng and opkg-trans was removed.
Updater won't remove package before replanning so add dependency on empty
opkg-trans package if we have installed version with those files (We would like to
use version_match but this condition has the same effect because version_match was
defined later than packages were merged.)
]]
if not version_match then
	Package('updater-ng', { deps = {'opkg-trans'} })
	if model:match("[Tt]urris") then
		-- On Turris 1.x we do the same also for updater as we are migrating from it in Turris OS 3.7.3'
		Package('updater-ng', { deps = {'updater'} })
	end
end

--[[
When we are updating from way old kernel we can have swconfig and kernel module
mismatch resulting in to the unconfigured switch. This ensures that new swconfig
is running on new kernel.

Note: version_match was introduced after installed started working so we check
if it's defined if we can use isntalled.
]]
if board:match("[Oo]mnia") then
	if not version_match or not installed["kmod-swconfig"] or \
		version_match(installed["kmod-swconfig"].version, "<4.4.40") then
		Package("swconfig", { reboot = "immediate" })
	end
end

--[[
In Turris OS 3.9 the package ip was renamed to ip-tiny to be consistent with lede.
But various packages requires package ip. In new updater we solve it using
Provides field but this won't work with all updater versions. This hack adds
virtual package ip for such updater version and basically just rebinds it to
ip-full.
]]
if not features.provides then
	Package("ip", { virtual = true, deps = {"ip-full"} })
end
