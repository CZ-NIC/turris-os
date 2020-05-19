#
# Copyright (C) 2019-2020 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=meson
PKG_VERSION:=0.54.1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/mesonbuild/meson/releases/download/$(PKG_VERSION)/
PKG_HASH:=2f76fb4572762be13ee479292610091b4509af5788bcceb391fe222bcd0296dc

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/host-build.mk

define Host/Compile
	true
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/meson
	$(CP) -R $(HOST_BUILD_DIR)/* $(STAGING_DIR_HOST)/meson/
endef

define Host/Clean
	$(call Host/Clean/Default)
	rm -rf $(STAGING_DIR_HOST)/meson
endef

$(eval $(call HostBuild))
