# 
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=zlib
PKG_VERSION:=1.2.11
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.zlib.net @SF/libpng
PKG_SH256SUM:=c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1

include $(INCLUDE_DIR)/host-build.mk

define Host/Configure
        (cd $(HOST_BUILD_DIR); \
                ./configure \
                        --prefix=$(STAGING_DIR_HOST) \
                        --shared \
                        --uname=Linux \
        );
endef

define Host/Compile
	+$(MAKE) $(PKG_JOBS) -C $(HOST_BUILD_DIR) \
		libz.a libz.so.$(PKG_VERSION)
	mkdir -p $(HOST_INSTALL_DIR)
	$(MAKE) -C $(HOST_BUILD_DIR) \
		DESTDIR="$(HOST_INSTALL_DIR)" \
		install
endef

$(eval $(call HostBuild))
