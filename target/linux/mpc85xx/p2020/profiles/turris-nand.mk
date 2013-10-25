#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

JFFS2_BLOCKSIZE := 128k
define Profile/TURRISNAND
	NAME:=Turris-nand
	PACKAGES:=\
		kmod-usb-core kmod-usb2 kmod-usb2-fsl \
		kmod-ath9k kmod-hostpad hostpad kmod-i2c-core \
		kmod-i2c-mpc kmod-usb-storage-extras kmod-usb-storage \
		block-mount kmod-mmc kmod-mmc-fsl-p2020 \
		vim-full mg \
		nuci updater daemon-watchdog logsend ucollect-count \
		ucollect-buckets unbound oneshot logrotate \
		mtd-utils mtd-utils-nandwrite mtd-utils-nandtest mtd-utils-nanddump \
		mtd-utils-flash-erase mtd-utils-flash-eraseall mtd-utils-flash-info
endef

define Profile/TURRISNAND/Description
	Package set optimized for the Turris NAND.
endef
$(eval $(call Profile,TURRISNAND))
