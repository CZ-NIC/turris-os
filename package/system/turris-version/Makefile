#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.8.5

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
create_notification -s news " • updater: oprava schvalování aktualizací
 • resolver: různé opravy hlavně ohledně lokálních jmen
 • knot-resolver: update na novou verzi
 • unbound: update na novou verzi
 • curl, ntpd, irssi a tor: bezpečnostní aktualizace" " • updater: fix apdate approvals
 • resolver: various fixes mainly regarding local domain names
 • knot-resolver: update to the latest version
 • unbound: update to the latest version
 • curl, ntpd, irssi a tor: security updates"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
