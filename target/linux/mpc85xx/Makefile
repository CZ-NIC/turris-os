#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

ARCH:=powerpc
BOARD:=mpc85xx
BOARDNAME:=Freescale MPC85xx
CPU_TYPE:=8540
FEATURES:=spe_fpu squashfs
MAINTAINER:=Imre Kaloz <kaloz@openwrt.org>
SUBTARGETS=p1010 p2020-nor p2020-nand

KERNEL_PATCHVER:=4.4

KERNEL_IMAGES := zImage

include $(INCLUDE_DIR)/target.mk

KERNELNAME:="zImage turris-nand-bch.dtb turris-nand-hw.dtb"

DEFAULT_PACKAGES += \
	kmod-input-core kmod-input-gpio-keys kmod-button-hotplug \
	kmod-leds-gpio \
	swconfig 

define Target/Description
	Build images for the Freescale MPC85xx based boards.
endef

$(eval $(call BuildTarget))
