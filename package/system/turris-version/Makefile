#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.5

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
create_notification -s news " • ath10k: implicitně použity ovladače WiFi ath10k namísto Candela Technologies ovladačů
 • mac80211, hostapd: aktualizace a opravy ovladačů, zapnutí FST (Fast Session Transfer)
 • lighttpd: při nedostatku entropie nedochází k občasnému zablokování startu systému
 • openssh: aktualizace na verzi 7.4p1
 • knot-resolver: podpora pro forwardování na více nadřazených DNS serverů
 • foris: navrácení stavu odesílání dat pro Turris, vyšší odolnost proti pádům NETCONF serveru
 • nuci: oprava obnovování konfigurace a chyb, které mohly vést k občasným pádům
 • opkg: opravy pádů při instalaci balíčků
 • ebtables: oprava pádů aplikace
 • fstrim: nový balíček" " •ath10k: use standard ath10k WiFi drivers as default instead of Candela Technologies drivers
 • mac80211, hostapd: fixes and updates of drivers, enabled FST (Fast Session Transfer)
 • lighttpd: does not block boot when kernel reports low entropy
 • openssh: updated to version 7.4p1
 • knot-resolver: support forwarding to multiple upstream DNS servers
 • foris: returned data sending status to About page, better tolerance for NETCONF server crashes
 • nuci: fixed configuration restore and errors that could lead to ocassional crashes
 • opkg: fixed crashes during package installation
 • ebtables: fixed application crashes
 • fstrim: new package"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
