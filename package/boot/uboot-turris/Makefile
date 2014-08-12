#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=u-boot
PKG_SOURCE_VERSION:=b02fcf400d49766be47d0f62d4452dbf962c1633
PKG_VERSION:=$(PKG_SOURCE_VERSION)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/u-boot-turris.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define uboot/Default
  TITLE:=
  CONFIG:=
  IMAGE:=
endef

define uboot/TURRIS1
  TITLE:=U-Boot for Turris
endef

define uboot/TURRIS1_SDCARD
  TITLE:=U-Boot for Turris SD card 
endef

UBOOTS := \
	TURRIS1 \
	TURRIS1_SDCARD

define Package/uboot/template
define Package/uboot-$(1)
  SECTION:=boot
  CATEGORY:=Boot Loaders
  DEPENDS:=@TARGET_mpc85xx_p2020_nor_TURRISNOR
  TITLE:=$(2)
  URL:=http://www.denx.de/wiki/U-Boot
  VARIANT:=$(1)
endef
endef

define BuildUBootPackage
	$(eval $(uboot/Default))
	$(eval $(uboot/$(1)))
	$(call Package/uboot/template,$(1),$(TITLE))
endef

ifdef BUILD_VARIANT
$(eval $(call uboot/$(BUILD_VARIANT)))
UBOOT_CONFIG:=$(if $(CONFIG),$(CONFIG),$(BUILD_VARIANT))
UBOOT_IMAGE:=$(if $(IMAGE),$(IMAGE),openwrt-$(BOARD)-$(BUILD_VARIANT)-u-boot.bin)
endif

define Build/Configure
	$(MAKE) -C $(PKG_BUILD_DIR) \
		$(UBOOT_CONFIG)_config
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CROSS_COMPILE=$(TARGET_CROSS) 
endef


define Package/uboot/install/default
	dd if=$(PKG_BUILD_DIR)/u-boot.bin of=$(BIN_DIR)/uboot-$(BOARD)-$(1) 
endef

define Package/uboot/install/sdcard
	$(STAGING_DIR_HOST)/bin/boot-format $(STAGING_DIR_HOST)/lib/boot-format/config_sram_p2020ds.dat \
		$(PKG_BUILD_DIR)/u-boot.bin -spi $(BIN_DIR)/uboot-$(BOARD)-$(1)
endef

define Package/uboot/install/template
define Package/uboot-TURRIS1/install
	$(call Package/uboot/install/default,$(2))
endef
define Package/uboot-TURRIS1_SDCARD/install
	$(call Package/uboot/install/sdcard,$(2))
endef
endef

$(foreach u,$(UBOOTS), \
	$(eval $(call Package/uboot/install/template,$(u),$(u))) \
)

$(foreach u,$(UBOOTS), \
	$(eval $(call BuildUBootPackage,$(u))) \
	$(eval $(call BuildPackage,uboot-$(u))) \
)
