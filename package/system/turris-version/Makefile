#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.8.2

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
create_notification -s news " • knot-resolver: automatické dočasné vypnutí IPv6 pokud nefunguje
 • mac80211: pár oprav převzaných z LEDE
 • updater: oprava aktualizace Turrisů 1.x z továrního nastavení
 • nextcloud-install: lepší práce s databází" " • knot-resolver: automaticly temporally turn off IPv6 if it doesn't work
 • mac80211: few fixes from LEDE
 • nextcloud-install: better database handling"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
