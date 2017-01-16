#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.5.1

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
create_notification -s news " • openssl: oprava CVE-2016-7056
 • knot-resolver: omezení forwardování jen na čtyři servery
 • watchcat: odebrán z LuCI userlistu jelikož současná verze způsobuje problémy (lze doinstalovat ručně)
 • opkg-trans: ošetření adresářů v .list souborech" " • openssl: fix CVE-2016-7056
 • knot-resolver: limit forwarding to only four servers
 • watchcat: no longer part of LuCI user list as current version causes some issues (still available in repo)
 • opkg-trans: handle directories in .list files"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
