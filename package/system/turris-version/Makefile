#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.4

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
create_notification -s news " • kernel: Aktualizace na nejnovější verzi
 • kernel: Zapnuta podpora pro NEON instrukce
 • foris-tls-plugin: Přidány chybějící překlady a generování QR kódů pro mobilní aplikaci
 • foris-diagnostics-plugin: Nový plugin pro generování diagnostických reportů
 • ucollect: Nové minipoty - HTTP proxy, Squid proxy a Polipo proxy; drobné opravy
 • python-turris-gpio: Podpora pro Turris Omnia
 • cups: Základní podpora tisku přes cups
 • mac80211: Aktualizace a opravy ovladačů WiFi
 • majordomo: Opravy resolvování DNS záznamů a práce s databází
 • nuci: Přidání konfigurace updateru do záloh, podpora konfigurovatelných záloh" " • kernel: Update to latest version
 • kernel: Enabled support for NEON instructions
 • foris-tls-plugin: Added missing translations and generation of QR codes for the mobile app
 • foris-diagnostics-plugin: New plugin for generation of diagnostic reports
 • ucollect: New minipots - HTTP proxy, Squid proxy and Polipo proxy; minor fixes
 • python-turris-gpio: Support for Turris Omnia
 • cups: Basic support for printing via cups
 • mac80211: Update and fixes of WiFi drivers
 • majordomo: Fixed DNS records resolving and database handling
 • nuci: Updater configuration added to backups, support for configurable backups"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
