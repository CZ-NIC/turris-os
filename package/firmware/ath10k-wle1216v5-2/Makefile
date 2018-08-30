#
# Copyright (C) 2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ath10k-wle1216v5-2
PKG_VERSION:=2017-06-01
PKG_RELEASE:=1

PKG_SOURCE:=WLE1216V5-2-board.bin
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://www.candelatech.com/downloads/ath10k-9984-10-4/
PKG_MD5SUM:=997e66fabd75f91f9f247e8eff9fa1b0

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

PKG_UNPACK=install -D "$(DL_DIR)/$(PKG_SOURCE)" "$(PKG_BUILD_DIR)"/board.bin

define Package/ath10k-wle1216v5-2
  SECTION:=firmware
  CATEGORY:=Firmware
  URL:=https://www.candelatech.com/ath10k-10.4.php
  TITLE:=Firmware for earlier versions of the WLE1216V5-20 (before October, 2017)
  DEPENDS:=+ath10k-firmware-qca9984-ct
endef

define Package/ath10k-wle1216v5-2/description
Earlier versions of the WLE1216V5-20 (before October, 2017) used the same
BMI-ID as the WLE1216V5-23, and had several issues. Probably you do not have
this NIC, but if you do, see below.

This NIC uses same BMI-id and PCI-id as the WLE1216V5-23, so by default the
ath10k driver will load the wrong board-file contents. The recent CT ath10k
driver supports specifying a unique board-file using the fwcfg feature. With
the latest beta CT firmware, and a customized board.bin it has been working
well in brief testing. Further testing showed several potential issues: When
the NIC is within about 8 feet or less of the AP, throughput suffers badly. At
12 feet and higher (in our tests), it runs well. A second problem is that the
NIC appears to radiate some near-field interference: If you bring up an idle
station on a WLE1216V5-20, it will significantly disrupt traffic running on
another NIC a few inches away. The WLE1216V5-23 and the Zcomax AC-924, which
uses the same 9984 chipset, does not appear to have this problem.
endef

define Build/Compile
	true
endef

define Package/ath10k-wle1216v5-2/install
	$(INSTALL_DIR) $(1)/lib/firmware/ath10k/QCA9984/hw1.0/
	$(CP) $(PKG_BUILD_DIR)/board.bin $(1)/lib/firmware/ath10k/QCA9984/hw1.0/
endef

$(eval $(call BuildPackage,ath10k-wle1216v5-2))
