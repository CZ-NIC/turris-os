#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.9.1

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
create_notification -s news " • coreutils: update na poslední verzi
 • uci: méně volání sync - teoreticky o něco málo rychlejší commit
 • hostapd: aktualizace patchů z LEDE
 • kernel: update, fat driver zakompilován do kernelu na Turrisech 1.X a oprava problému s LXC
 • pakon: robustnější instalace
 • haas-proxy: robustnější integrace do firewallu
 • updater: robustnější aktualizace a opravy lokálních rep
 • knot-resolver: aktualizace na nejnovější verzi
 • foris: aktualizované překlady a více diagnostik, oprava různých drobných chyb" " • coreutils: update to the latest version
 • uci: less sync calls - in theory a little faster commits
 • hostapd: updated patches from LEDE
 • kernel: update to the latest version, fix for problems with LXC containers
 • pakon: more robust installation
 • haas-proxy: more robust firewall integration
 • updater: more robust updates and fixes to local repos handling
 • knot-resolver: update to the latest version
 • foris: updated translations and more diagnostics, fixed various minor bugs"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
