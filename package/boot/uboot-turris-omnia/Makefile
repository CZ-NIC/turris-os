#
# Copyright (C) 2013-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=uboot-turris-omnia
PKG_VERSION:=2015.10
PKG_RELEASE:=2
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/turris-omnia-uboot.git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_VERSION:=337370874bc0f7b9692cda2525ee125c99f90742
PKG_SOURCE_SUBDIR:=turris-omnia-uboot
PKG_MAINTAINER:=Michal Hrusecky <MichalHrusecky@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

PKG_LICENSE:=GPL-2.0 GPL-2.0+
PKG_LICENSE_FILES:=Licenses/README

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/host-build.mk

define Package/uboot-turris-omnia
  TITLE:=U-Boot for Turris Omnia
  SECTION:=boot
  DESCRIPTION=
  CATEGORY:=Boot Loaders
  DEPENDS:=@TARGET_mvebu_Turris-Omnia uboot-envtools
  URL:=http://www.denx.de/wiki/U-Boot
endef

define Package/uboot-turris-omnia/description
  U-Boot bootloader for Turris Omnia router
endef

define Build/Configure
	$(MAKE) -C $(PKG_BUILD_DIR) USE_PRIVATE_LIBGCC=yes db-88f6820-gp_defconfig
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) CROSS_COMPILE=$(TARGET_CROSS) DTC=$(LINUX_DIR)/scripts/dtc/dtc
	cp $(PKG_BUILD_DIR)/u-boot-spl.kwb $(PKG_BUILD_DIR)/uboot-turris-omnia-spl.kwb
	sed -i 's|.*\(CONFIG_MVEBU_BOOTROM_UARTBOOT\).*|\1=y|' $(PKG_BUILD_DIR)/.config
	sed -i 's|spi|uart|' $(PKG_BUILD_DIR)/board/Marvell/db-88f6820-gp/kwbimage.cfg
	$(MAKE) -C $(PKG_BUILD_DIR) CROSS_COMPILE=$(TARGET_CROSS) DTC=$(LINUX_DIR)/scripts/dtc/dtc
	cp $(PKG_BUILD_DIR)/u-boot-spl.kwb $(PKG_BUILD_DIR)/uboot-turris-omnia-uart-spl.kwb
	mkdir -p $(HOST_BUILD_DIR)/$(PKG_SOURCE_SUBDIR)
	$(HOSTCC) $(HOST_CFLAGS) -static -o $(HOST_BUILD_DIR)/$(PKG_SOURCE_SUBDIR)/kwboot $(PKG_BUILD_DIR)/tools/kwboot.c
	$(HOSTCC) $(HOST_CFLAGS) -static -o $(HOST_BUILD_DIR)/$(PKG_SOURCE_SUBDIR)/sendbeacon ./files/sendbeacon.c
endef

define Package/uboot-turris-omnia/install
	$(INSTALL_DIR) $(1)/boot/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/uboot-turris-omnia-spl.kwb $(1)/boot/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/uboot-turris-omnia-uart-spl.kwb $(1)/boot/
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/$(PKG_SOURCE_SUBDIR)/kwboot $(HOST_INSTALL_DIR)
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/$(PKG_SOURCE_SUBDIR)/sendbeacon $(HOST_INSTALL_DIR)
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
