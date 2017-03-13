#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.6.1

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
create_notification -s news " • dhparams: opraveno vytváření symlinků a tím i OpenVPN plugin
 • util-linux: opraveno sestavování některých součástí a balíčků na nich závisejících
 • luci-app-statistics: zabránění přepisu konfiguračních souborů
 • vixie-cron: přidány prázdné adrešáře které jsou v současném stavu nutné pro běh" " • dhparams: fix symlink creation to fix OpenVPN plugin
 • util-linux: fix building of some parts and dependent packages
 • luci-app-statistics: mark configuration files as such to prevent overwriting
 • vixie-cron: included empty currently needed directories"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
