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
create_notification -s news " • různé aktualizace balíčků
 • foris: přidána možnost nastavovat čashu
 • pakon: webové rozhraní ve Forisu a lepší filtrování výsledků
 • updater: odstraněn zastaralý updater.sh, používejte pkgupdate přímo
 • foris: storage modul pro přesun často přepisovaných dat na externí úložiště
 • foris: modul pro zálohy do cloudu
 
 Pokud dojde ke zničení interní eMMC flash z důvodu nadměrného zapisování, především kvůli provozu LXC kontejnerů bez externího úložiště, nemusí se na její opravu vztahovat záruka." " • various upstream packages updates
 • foris: posibility to change time settings outside of wizard
 • pokon: web ui in Foris and better results filtering
 • updater: droped obsolete updater.sh and friends, use pkgupdate directly
 • foris: plugin to move IO intensive data to external drive
 • foris: plugin for cloud backups
 
 Excessive writing to the internal flash disk (eMMC) wear it out and this can result in irreparable damage to your device, which doesn't have to be covered by warranty."
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
