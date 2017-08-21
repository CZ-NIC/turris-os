#
## Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=go
PKG_VERSION:=1.8.3.
PKG_RELEASE:=1
PKG_SOURCE_URL:=https://storage.googleapis.com/golang/
PKG_SOURCE:=$(PKG_NAME)$(PKG_VERSION)linux-amd64.tar.gz
PKG_MD5:=
PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
HOST_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_INSTALL:=1

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SUBMENU:=Go
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Go programing language compiler
  URL:=https://golang.org
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Build/Install
endef

define Build/Clean
endef

define Host/Configure
endef

define Host/Compile
endef

define Host/Install
	cp -r $(BUILD_DIR)/$(PKG_NAME) $(STAGING_DIR_HOST)
	echo $(BUILD_DIR)
endef

define Host/Clean
	rm -rf $(STAGING_DIR_HOST)/$(PKG_NAME)/
	rm -rf $(BUILD_DIR)/$(PKG_NAME)/
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,$(PKG_NAME)))

