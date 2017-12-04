#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.9

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
create_notification -s news " • netmetr: možnost aktivního měření propustnosti linky
 • ssh-honeypot: migrace na systém haas
 • updater: přesun konfiguračních souborů
 • foris: velký úklid v backendu
 • pakon: parental control / sledování sítě, technologické demo (CLI)
 • aktualizace různých blíčků" " • netmetr: active bandwidth testing tool
 • ssh-honeypot: migration to haas service
 • updater: moving and splitting configuration files
 • foris: big backend cleanup
 • pakon: parental control / network monitoring, CLI only preview
 • various package updates"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
