#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=uboot-envtools
PKG_DISTNAME:=u-boot
PKG_VERSION:=2018.03
PKG_RELEASE:=5

PKG_SOURCE_PROTO:=git
PKG_SOURCE:=$(PKG_DISTNAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_SUBDIR:=$(PKG_DISTNAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_DISTNAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://git.denx.de/u-boot.git
PKG_SOURCE_VERSION:=f95ab1fb6e37f0601f397091bb011edf7a98b890
PKG_MIRROR_HASH:=b50d8b6fe0d90b92c8c147457b1b4c2ed1cdb03191085cfc57fdad77c0bfffab

PKG_BUILD_DEPENDS:=fstools

PKG_LICENSE:=GPL-2.0 GPL-2.0+
PKG_LICENSE_FILES:=Licenses/README

PKG_FLAGS:=nonshared

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/uboot-envtools
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Boot Loaders
  TITLE:=read/modify U-Boot bootloader environment
  URL:=http://www.denx.de/wiki/U-Boot
endef

define Package/uboot-envtools/description
 This package includes tools to read and modify U-Boot bootloader environment.
endef

define Package/uboot-mkimage
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Boot Loaders
  DEPENDS:=+libopenssl
  TITLE:=Prepare files for U-Boot bootloader
  URL:=http://www.denx.de/wiki/U-Boot
endef

define Package/uboot-mkimage/description
 This package includes tool prepare various files for U-Boot bootloader.
endef


define Build/Configure
	touch $(PKG_BUILD_DIR)/include/config.h
	mkdir -p $(PKG_BUILD_DIR)/include/config
	touch $(PKG_BUILD_DIR)/include/config/auto.conf
	mkdir -p $(PKG_BUILD_DIR)/include/generated
	touch $(PKG_BUILD_DIR)/include/generated/autoconf.h
endef

TARGET_CFLAGS += -I$(STAGING_DIR)/usr/include

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		TARGET_CFLAGS="$(TARGET_CFLAGS)" \
		HOSTLDFLAGS= \
		no-dot-config-targets=envtools \
		envtools
	mv $(PKG_BUILD_DIR)/tools/env/fw_printenv $(PKG_BUILD_DIR)/tools/env/fw_printenv.bak
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		TARGET_CFLAGS="$(TARGET_CFLAGS)" \
		HOSTLDFLAGS= \
		defconfig	cross_tools
endef

define Package/uboot-envtools/conffiles
/etc/config/ubootenv
/etc/fw_env.config
endef

define Package/uboot-envtools/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tools/env/fw_printenv.bak $(1)/usr/sbin/fw_printenv
	$(LN) fw_printenv $(1)/usr/sbin/fw_setenv
	$(INSTALL_DIR) $(1)/lib
	$(INSTALL_DATA) ./files/uboot-envtools.sh $(1)/lib
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(if $(wildcard ./files/$(BOARD)), \
		$(INSTALL_DATA) ./files/$(BOARD) \
		$(1)/etc/uci-defaults/30_uboot-envtools \
	)
ifneq ($(CONFIG_TARGET_mpc85xx_p2020_nand_TURRISNAND),)
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) ./files/turris.cfg $(1)/etc/fw_env.config
endif
ifneq ($(CONFIG_TARGET_mvebu_Turris-Omnia),)
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) ./files/turris-omnia.cfg $(1)/etc/fw_env.config
endif
endef

define Package/uboot-mkimage/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tools/mkimage $(1)/usr/sbin
endef

$(eval $(call BuildPackage,uboot-envtools))
$(eval $(call BuildPackage,uboot-mkimage))
