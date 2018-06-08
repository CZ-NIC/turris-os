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
create_notification -s news " • haas: oprava integrace do firewallu
 • ucollect: robustnější start
 • updater: oprava kolizí při upgrade ze starých verzí
 • dvbsky: oprava kompilace ovladače
 • nut: oprava aktualizace
 • kernel, nextcloud: aktualizace" " • haas: fix firewall integration
 • ucollect: more robust start
 • updater: fix collisions when updating from old versions
 • dvbsky: fix driver compilation
 • nut: fix update
 • kernel, nextcloud: update"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
