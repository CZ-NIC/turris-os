#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

JFFS2_BLOCKSIZE := 128k
define Profile/Turris-nor
	NAME:=Turris-nor
	PACKAGES:=\
		kmod-usb-core kmod-usb2 kmod-usb2-fsl \
                kmod-ath9k kmod-hostpad hostpad kmod-i2c-core \
		kmod-i2c-mpc kmod-usb-storage-extras kmod-usb-storage \
		block-mount kmod-mmc kmod-mmc-fsl-p2020 \
		vim-full mg 

endef

define Profile/Turris-nor/Description
	Package set optimized for the Turris NOR.
endef

define Profile/Turris-nand
        NAME:=Turris-nand
        PACKAGES:=\
                kmod-usb-core kmod-usb2 kmod-usb2-fsl \
                kmod-ath9k kmod-hostpad hostpad kmod-i2c-core \
                kmod-i2c-mpc kmod-usb-storage-extras kmod-usb-storage \
                block-mount kmod-mmc kmod-mmc-fsl-p2020 \
                vim-full mg

endef

define Profile/Turris-nand/Description
        Package set optimized for the Turris NAND.
endef

$(eval $(call Profile,Turris-nor))
$(eval $(call Profile,Turris-nand))
