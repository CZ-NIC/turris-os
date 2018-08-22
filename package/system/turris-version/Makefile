#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.10.5

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
create_notification -s news " • kernel, odhcpv6, twisted, openssh: aktualizace
 • ca-certificates: přídán balíček pro balík certifikátů
 • base: zapnuto TCP fast open
 • haas-proxy: jistější omezení využití CPU
 • odhcpv6: vypnuta podpora unicastu (způsobovalo problémy v některých sítích), lze zapnout v /etc/config/network" " • kernel, odhcpv6, twisted, openssh: update
 • ca-certificates: package for ca bundle
 • base: enable TCP fast open
 • haas-proxy: more robust CPU usage limits
 • odhcpv6: disable unicast support (caused problems in some networks), can be enabled in /etc/config/network"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
