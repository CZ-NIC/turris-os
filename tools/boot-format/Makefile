#
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=boot-format
PKG_SOURCE_VERSION:=e9c6558e5905eff69e7da73814b1c4d9ed6dbcfd
PKG_VERSION:=$(PKG_SOURCE_VERSION)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/boot-format.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/host-build.mk

define Host/Compile
	$(MAKE) -C $(HOST_BUILD_DIR)
endef

define Host/Install
	$(CP) $(HOST_BUILD_DIR)/boot_format $(STAGING_DIR_HOST)/bin/boot-format
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/lib/boot-format
	$(CP) $(HOST_BUILD_DIR)/*.dat $(STAGING_DIR_HOST)/lib/boot-format/
endef

define Host/Clean
	 $(MAKE) -C $(HOST_BUILD_DIR) clean || true
endef

$(eval $(call HostBuild))
