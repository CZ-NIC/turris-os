#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
JFFS2_BLOCKSIZE := 128k
NAND_BLOCKSIZE := 2048:128k
TURRISNAND_DTS:="turris-nand"
TURRISNAND_UBIFS_OPTS:="-m 2048 -e 124KiB -c 2000 -F"
TURRISNAND_UBI_OPTS:="-m 2048 -p 128KiB -s 2048"

define Profile/TURRISNAND
	NAME:=Turris-nand
# Hacks:
# * zlib is included so curl gets --compress. Even when curl depends on it, it
#   was not available at the time of compilation. Maybe some kind of race
#   condition.
# * cert-backup is conditional dependency on some targets (eg. this one). The
#   build system is confused enough not to select it automatically, so we list
#   it here explicitly.
	PACKAGES:=\
		kmod-usb-core kmod-usb2 kmod-usb2-fsl \
		kmod-ath9k kmod-hostapd hostapd kmod-usb3 \
		kmod-usb-storage \
		block-mount kmod-hwmon-core kmod-hwmon-lm90 \
		nuci updater unbound oneshot logrotate \
		mtd-utils mtd-utils-nandwrite \
		mtd-utils-flash-erase mtd-utils-flash-eraseall mtd-utils-flash-info \
		luci luci-i18n-czech zlib curl cert-backup foris update_mac wget \
		userspace_time_sync openssh-moduli watchdog_adjust \
		ucollect-config rainbow wpa-supplicant turris-version \
		spidev-test i2c-tools -dropbear
endef

define Profile/TURRISNAND/Description
	Package set optimized for the Turris NAND.
endef
$(eval $(call Profile,TURRISNAND))
