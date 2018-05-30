#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.10.1

PKG_MAINTAINER:=CZ.NIC <packaging@nic.cz>

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
create_notification -s news " • foris: podpora 6in4 a 6to4
 • foris: mo6nost zvolit si protokol u VPN
 • kernel: aktualizace a přidán UAS ovladač
 • foris-pakon: různé opravy a vylepšní kompatibility
 • odhcp6c: oprava chování po aktualizaci
 • netmetr: oprava synchronizačního kédu" " • foris: support 6in4 and 6 to4
 • foris: ability to set protocol in VPN
 • kernel: update and UAS driver
 • foris-pakon: bug and compatibility fixes
 • odhcp6c: fix after update
 • netmetr: fix synchronization code"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
