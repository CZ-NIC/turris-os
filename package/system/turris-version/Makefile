#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.9.2

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
create_notification -s news " • openssl: bezpečnostní aktualizace
 • musl & busybox: použití silnějších hashů na hesla ve výchozím stavu
 • kernel: update na poslední verzi
 • netmetr: oprava přepisování konfigurace
 • libtiff, socat, rsync, coreutils, php: bezpečnostní aktualizace
 • tvheadend: update na poslední verzi
 • suricata: oprava chyby spouštění na některých routerech, zlepšení výkonu" " • openssl: security update
 • musl & busybox: use stronger password hash by default
 • kernel: update to the latest version
 • netmetr: fix configuration reset
 • libtiff, socat, rsync, coreutils, php: security updates
 • tvheadend: update to the latest version
 • suricata: fix startup issue on some routers, performance tweaks"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
