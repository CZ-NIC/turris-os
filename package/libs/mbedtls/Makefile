#
# Copyright (C) 2011-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libmbedtls
PKG_VERSION:=2.4.2
PKG_RELEASE:=1
PKG_USE_MIPS16:=0

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-gpl.tgz
PKG_SOURCE_URL:=https://tls.mbed.org/download/
PKG_MD5SUM:=31dc8692fd2a4ada0af6a74b7b06c507

PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=GPL-2.0+

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libmbedtls/Default
  SUBMENU:=SSL
  TITLE:=Embedded SSL (library)
  URL:=https://tls.mbed.org
  SECTION:=libs
  CATEGORY:=Libraries
  ABI_VERSION:=$(PKG_VERSION)-$(PKG_RELEASE)
endef

define Package/libmbedtls/Default/description
The aim of the mbedtls project is to provide a quality, open-source
cryptographic library written in C and targeted at embedded systems.
This package contains the mbedtls library.
endef

PKG_INSTALL:=1

TARGET_CFLAGS += -ffunction-sections -fdata-sections

CMAKE_OPTIONS += \
	-DCMAKE_BUILD_TYPE:String="Release" \
	-DUSE_SHARED_MBEDTLS_LIBRARY:Bool=ON \
	-DENABLE_TESTING:Bool=OFF \
	-DENABLE_PROGRAMS:Bool=OFF \

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/mbedtls $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib*.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib*.a $(1)/usr/lib/
endef

define Package/libmbedtls/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib*.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libmbedtls))
