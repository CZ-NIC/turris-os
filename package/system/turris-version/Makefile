#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.10

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
create_notification -s news " • různé aktualizace
 • foris: přidána možnost nastavovat čas
 • pakon: webové rozhraní ve Forisu a lepší filtrování výsledků
 • foris: storage modul pro přesun často přepisovaných dat na externí úložiště
 • foris: modul pro zálohy do cloudu
 
 TBD eMMC warning" " • various updates
 • foris: posibility to change time settings outside of wizard
 • pokon: web ui in Foris and better results filtering
 • foris: plugin to move IO intensive data to external drive
 • foris: plugin for cloud backups
 
 TBD eMMC warning"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
