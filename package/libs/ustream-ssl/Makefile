include $(TOPDIR)/rules.mk

PKG_NAME:=ustream-ssl
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://git.openwrt.org/project/ustream-ssl.git
PKG_SOURCE_DATE:=2018-07-30
PKG_SOURCE_VERSION:=23a3f2830341acd1db149175baf7315a33bd0edb
PKG_MD5SUM:=289bef5dac684015b6a40cfd72cf1c8c297bb77cf2efd54e562b628ba3afd83d
CMAKE_INSTALL:=1

PKG_SOURCE:=$(PKG_NAME).tar.xz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)

PKG_BUILD_DIR=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_SOURCE_SUBDIR)

PKG_LICENSE:=ISC
PKG_LICENSE_FILES:=

PKG_MAINTAINER:=Felix Fietkau <nbd@nbd.name>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libustream/default
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=ustream SSL Library
  DEPENDS:=+libubox
  ABI_VERSION:=$(PKG_VERSION)
endef

define Package/libustream-openssl
  $(Package/libustream/default)
  TITLE += (openssl)
  DEPENDS += +PACKAGE_libustream-openssl:libopenssl
  VARIANT:=openssl
endef

define Package/libustream-mbedtls
  $(Package/libustream/default)
  TITLE += (mbedtls)
  DEPENDS += +libmbedtls
  VARIANT:=mbedtls
  DEFAULT_VARIANT:=1
endef

ifeq ($(BUILD_VARIANT),mbedtls)
  CMAKE_OPTIONS += -DMBEDTLS=on
endif

define Package/libustream/default/install
	$(INSTALL_DIR) $(1)/lib/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/libustream-ssl.so $(1)/lib/
endef

Package/libustream-openssl/install = $(Package/libustream/default/install)
Package/libustream-mbedtls/install = $(Package/libustream/default/install)

$(eval $(call BuildPackage,libustream-mbedtls))
$(eval $(call BuildPackage,libustream-openssl))
