#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

JFFS2_BLOCKSIZE := 128k
define Profile/P2020RDBPCA
	NAME:=P2020RDB-PCA
	PACKAGES:=\
		kmod-usb-core kmod-usb2 kmod-usb2-fsl
endef

define Profile/P2020RDBPCA/Description
	Package set optimized for the P2020RDB-PCA.
endef
$(eval $(call Profile,P2020RDBPCA))
