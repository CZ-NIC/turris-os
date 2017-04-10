#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.6.2

PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>

include $(INCLUDE_DIR)/package.mk

define Package/turris-version
	TITLE:=turris-version
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/turris-version/postinst
#!/bin/sh
# Danger: spaces are not ordinary spaces, but special unicode ones
[ -n "$$IPKG_INSTROOT" ] || {
create_notification -s news " • logrotate: opravena výchozí konfigurace
 • openvpn: update na novější verzi
 • mdadm: oprava mailových upozornění
 • curl: oprava CVE-2017-7407
 • bird: oprava vytváření uživatele
 • kernel: oprava CVE-2017-7184
 • ntpd: update na poslední verzi
 • knot-resolver: update na poslední verzi" " • logrotate: fix default configuration
 • openvpn: update to the newer version
 • mdadm: fix mail notifications
 • curl: fix CVE-2017-7407
 • bird: fix user creation
 • kernel: fix CVE-2017-7184
 • ntpd: update to the latest version
 • knot-resolver: update to the latest version"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
