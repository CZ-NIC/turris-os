#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.5.2

PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>

include $(INCLUDE_DIR)/package.mk

define Package/turris-version
	TITLE:=turris-version
endef

define Build/Prepare
endef

define Build/Compile
endef

opkg: Use repo.turris.cz because of certificates
* ntpd: updated to the current version
* knot-resolver: remove AD flag in forwarding mode
* updated and fixed switch driver


define Package/turris-version/postinst
#!/bin/sh
# Danger: spaces are not ordinary spaces, but special unicode ones
[ -n "$$IPKG_INSTROOT" ] || {
create_notification -s news " • ntpd: aktualizace na poslední verzi opravující různé bezpečnostní chyby
 • knot-resolver: odstranění AD příznaku během forwardování
 • opkg & lxc: výchozí URL změněno na repo.turris.cz místo api.turris.cz" " • ntpd: updated to the last version fixing various security issues
 • knot-resolver: removed AD flag in forwarding mode
 • opkg & lxc: default URL changed to repo.turris.cz instead of api.turris.cz"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
