#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ninja
PKG_VERSION:=1.9.0

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/ninja-build/ninja/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=5d7ec75828f8d3fd1a0c2f31b5b0cea780cdfe1031359228c428c1a48bfcd5b9

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1
HOST_BUILD_PARALLEL:=1

HOST_BUILD_DIR:=$(BUILD_DIR)/ninja-$(PKG_VERSION)

include $(INCLUDE_DIR)/host-build.mk

CONFIGURE_ARGS := \
	--bootstrap

HOST_CONFIGURE_ARGS := $(CONFIGURE_ARGS)

define Host/Compile
	cd  $(HOST_BUILD_DIR) && python3 configure.py $(HOST_CONFIGURE_ARGS)
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/usr/bin/
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/ninja $(STAGING_DIR_HOST)/usr/bin/
endef

define Host/Clean
	$(call Host/Clean/Default)
	rm $(STAGING_DIR_HOST)/usr/bin/ninja
endef

$(eval $(call HostBuild,ninja))
