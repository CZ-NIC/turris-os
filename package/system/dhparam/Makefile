#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=dhparam
PKG_VERSION:=2.0

PKG_MAINTAINER:=Michal Hrusecky <michal.hrusecky@nic.cz>

include $(INCLUDE_DIR)/package.mk

define Package/dhparam
	TITLE:=Pregenerated Diffie-Hellman parameters
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/dhparam/postinst
#!/bin/sh
# Danger: spaces are not ordinary spaces, but special unicode ones
[ -n "$$IPKG_INSTROOT" ] || {
	if [ ! -f /etc/dhparam/dh-default.pem ]; then
		if [ -f /etc/dhparams/dh2048.pem ]; then
			ln -s /etc/dhparam/dh2048.pem /etc/dhparam/dh-default.pem
		else
			ln -s /etc/dhparam/dh4096.pem /etc/dhparam/dh-default.pem
		fi
	fi
	[ -f /etc/dhparams/dh2048.pem ] || {
		ln -s ../../usr/share/dhparam/dhparam.init /etc/init.d/dhparam
		/etc/init.d/dhparam enable
		/etc/init.d/dhparam start
	}
}
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	rm /etc/dhparam/dh-default.pem
	rm -f /etc/init.d/dhparam
}
endef

define Package/dhparam/conffiles
/etc/dhparam/*.pem
endef

define Package/dhparam/install
	$(INSTALL_DIR) $(1)/etc/dhparam
	$(CP) ./files/*.pem $(1)/etc/dhparam
	$(INSTALL_DIR) $(1)/usr/share/dhparam
	$(CP) ./files/*.sh $(1)/usr/share/dhparam
	$(INSTALL_BIN) ./files/*.init $(1)/usr/share/dhparam
endef

$(eval $(call BuildPackage,dhparam))
