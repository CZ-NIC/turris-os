#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.9.4

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
create_notification -s news " • hass: update na novou verzi
 • haas: robustnější registrace
 • kernel: update na poslední verzi, ovladače na Sierra Wireless EM7565
 • nextcloud: update na poslední verzi
 • foris: oprava DNS tabu pro uživatele pod smlouvou, pročistění závislostí
 • poco, mariadb, curl, unbound, bind: bezpečnostní aktualizace" " • haas: update to the latest version
 • haas: more robust registration
 • kernel: update to the latest version, Sierra Wireless EM7565 drivers
 • nextcloud: update to the latest version
 • foris: cleanup some dependencies
 • poco, mariadb, curl, unbound, bind: security updates"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
