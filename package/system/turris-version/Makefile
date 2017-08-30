#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.8

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
create_notification -s news " • foris: možnost nastavit limity pro návštěvnickou síť
 • foris: možnost nechat propagovat jména klientů do lokálního DNS
 • foris a updater: možnost odložených aktualizací
 • foris: ruský, dánský a litevský překlad
 • userlisty: prořezány závisloti
 • suricata: update na novou verzi, modulárnější konfigurace, podpůrné balíčky
 • php7: přidána podpora
 • mariadb: nový balíček
 • nextcloud: základní podpora zatím bez integrace
 • turris 1.X: kernel 4.4 a podpora migrace na btrfs na Micro SD kartě
 • nfsv4: základní podpora
 • hardware feed: přidáno několik balíčků týkající se práce s hardware" " • foris: option to set bandwidth limits for guest network
 • foris: option to propagate client names into local DNS
 • foris and updater: delayed updates
 • foris: russian, danish and lithuanian translations added
 • userlists: trimed down dependencies
 • suricata: new version, more modular configuration, helper packages
 • php7: newly supported
 • mariadb: new package
 • nextcloud: basic support without much integration
 • nfsv4: basic support
 • hardware feed: few hardware related packages"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
