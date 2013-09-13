#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/Turris
	NAME:=Turris
	PACKAGES:=\
		kmod-usb-core kmod-usb2 kmod-usb2-fsl
endef

define Profile/Turris/Description
	Package set optimized for the Turris.
endef
$(eval $(call Profile,Turris))
