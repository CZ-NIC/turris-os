#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=meson
PKG_VERSION:=0.51.0
PKG_RELEASE:=1

PKG_SOURCE:=meson-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/mesonbuild/meson/releases/download/$(PKG_VERSION)/
PKG_HASH:=2f75fdf6d586d3595c03a07afcd0eaae11f68dd33fea5906a434d22a409ed63f

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=COPYING

HOST_BUILD_DIR:=$(BUILD_DIR)/meson-$(PKG_VERSION)

include $(INCLUDE_DIR)/host-build.mk

ENDIAN := $(if $(CONFIG_BIG_ENDIAN),big,little)

#CROSS_CONF contains utility which will be used
#to crosscompile target based on meson.build file
CROSS_CONF=$(STAGING_DIR)/cross_conf.txt

define Host/Compile
	echo [binaries] >$(CROSS_CONF)
	echo c = \'$(TARGET_CC_NOCACHE)\' >>$(CROSS_CONF)
	echo cpp = \'$(TARGET_CXX_NOCACHE)\'>>$(CROSS_CONF)
	echo ar = \'$(TARGET_AR)\'>>$(CROSS_CONF)
	echo strip = \'$(TARGET_CROSS)strip\' >> $(CROSS_CONF)
	echo nm = \'$(TARGET_NM)\' >> $(CROSS_CONF)
	echo ld = \'$(TARGET_CROSS)ld\' >> $(CROSS_CONF)
	echo pkgconfig = \'$(PKG_CONFIG).real\'>>$(CROSS_CONF)

	echo [host_machine]>>$(CROSS_CONF)
	echo system = \'linux\'>>$(CROSS_CONF)
	echo cpu_family = \'$(ARCH)\'>>$(CROSS_CONF)
	echo cpu = \'$(CONFIG_TARGET_SUBTARGET)\'>>$(CROSS_CONF)
	echo endian = \'$(ENDIAN)\' >> $(CROSS_CONF)
	echo [build_machine]>>$(CROSS_CONF)
	echo system = \'linux\'>>$(CROSS_CONF)
	echo cpu_family = \'x86_64\'>>$(CROSS_CONF)
	echo cpu = \'i686\'>>$(CROSS_CONF)
	echo endian = \'little\'>>$(CROSS_CONF)
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/meson
	$(CP) -R $(HOST_BUILD_DIR)/* $(STAGING_DIR_HOST)/meson/
endef

$(eval $(call HostBuild))
