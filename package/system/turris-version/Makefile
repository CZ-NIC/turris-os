#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.6

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
create_notification -s news " • foris: nový plugin pro snadné nastavení OpenVPN
 • suricata: nový balíček pro IDS
 • kernel: podpora CPUFreq, w1-gpio-cust a EC25-E LTE modulu na Omnii
 • nové verze různých balíčků, hlavně DNS resolverů" " • foris: new plugin for easy OpenVPN management
 • suricata: new package for IDS
 • kernel: support for CPUFreq, w1-gpio-cust and EC25-E LTE module on Omnia
 • updates to various packages, especially DNS resolvers"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
