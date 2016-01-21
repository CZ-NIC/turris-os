# 
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=zlib
PKG_VERSION:=1.2.8
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.zlib.net @SF/libpng
PKG_MD5SUM:=44d667c142d7cda120332623eab69f40

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
