# 
# Copyright (C) 2006 OpenWrt.org
# Copyright (C) 2015 CZ.NIC
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ca-certificates
PKG_VERSION:=20141019

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION).tar.xz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=http://ftp.debian.org/debian/pool/main/c/ca-certificates
PKG_MD5SUM:=f619282081c8bfc65ea64c37fa5285ed

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/ca-certificates
  SECTION:=base
  CATEGORY:=Base system
  TITLE:=System CA certificates
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
	ls $(1)/etc/ssl/certs/*.crt | while read cert ; do mv $$$${cert} $$$${cert}.pem ; done
	c_rehash $(1)/etc/ssl/certs
endef

$(eval $(call BuildPackage,ca-certificates))
