#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.9.6

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
create_notification -s news " • haas: update a oprava logování a firewallu
 • irssi, rsync, dovecot, squid, mxml, libvorbis, libtasn1, unzip, php: bezpečnostní aktualizace
 • xfsprogs: přidán nástroj xfs_admin
 • uClibc: zapnuty silnější hashe
 • luci-lxc: oprava vytváření kontejnerů
 • kernel: aktualizace, přidány moduly pro dvb-mn88473, dvb-usb-cxusb
 • dnsmasq: oprava sekvenčního přiřazování adres
 • suricata: oprava obejití chyb s IPv6" " • haas: update and fix loging and firewall
 • irssi, rsync, dovecot, squid, mxml, libvorbis, libtasn1, unzip, php: security updates
 • xfsprogs: add xfs_admin tool
 • luci-lxc: fix container creation
 • kernel: update, modules for dvb-mn88473 and dvb-usb-cxusb added
 • dnsmasq: fix sequential ip assignement
 • suricata: fix workaround for some IPv6 issues"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

$(eval $(call BuildPackage,turris-version))
