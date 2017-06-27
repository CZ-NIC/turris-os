#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.7.1

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
create_notification -s news " • kernel: update na novější verzi řešící různé bezpečnostní chyby
 • openvpn: update na novější verzi řešící různé bezpečnostní chyby
 • knot: update na novější verzi řešící různé bezpečnostní chyby
 • luci-ssl: oprava závislostí
 • foris: oprava sbírání dat
 • printing: odebrán cups z printing userlistu pro staré turrisy" " • kernel: security update to the newer version
 • opnvpn: security update to the newer version
 • knot: security update to the newer version
 • luci-ssl: fix dependencies
 • foris: fix data collecting
 • printing: cups removed from userlist for old turris routers"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
