#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.5.3

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
create_notification -s news " • wget: zajištění aby busybox wget nepřepisoval opravdový wget
 • openssl: opraveno několik bezpečnostních chyb
 • libpcap: opraveno několik bezpečnostních chyb
 • tcpdump: opraveno několik bezpečnostních chyb, zrušena mini varianta" " • wget: making sure busybox wget doesn't override the real one
 • openssl: fix various security issues
 • libpcap: fix various security issues
 • tcpdump: fix various security issuse, dropped mini variant"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
