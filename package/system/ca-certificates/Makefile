#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ca-certificates
PKG_VERSION:=20170717

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION).tar.xz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_SOURCE_URL:=http://ftp.debian.org/debian/pool/main/c/ca-certificates
PKG_MD5SUM:=55a6bb6b98afb16b3cde8e3ad1e262eb

PKG_INSTALL:=1
PKG_REVISION:=1

include $(INCLUDE_DIR)/package.mk

define Package/ca-certificates
  SECTION:=base
  CATEGORY:=Base system
  TITLE:=System CA certificates
  DEPENDS:=+c-rehash
endef

define Build/Install
	mkdir -p \
		$(PKG_INSTALL_DIR)/usr/sbin \
		$(PKG_INSTALL_DIR)/usr/share/ca-certificates
	$(call Build/Install/Default,)
endef

define Package/ca-certificates/install
	$(INSTALL_DIR) $(1)/etc/ssl/certs
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/ca-certificates/*/*.crt $(1)/etc/ssl/certs/
endef
define Package/$(PKG_NAME)/postinst
#!/bin/sh

cd "$${IPKG_INSTROOT}"/etc/ssl/certs
c_rehash .
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh

( cd /etc/ssl/certs && c_rehash . ) || true
endef

$(eval $(call BuildPackage,ca-certificates))
