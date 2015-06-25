#
### Copyright (C) 2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
### This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# # #
# #
#

include $(TOPDIR)/rules.mk

PKG_NAME:=uboot-turris
PKG_VERSION:=1
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

UBOOT_JFFS2:=$(TOPDIR)/uboot-static/uboot-mpc85xx-TURRIS1-jffs2
UBOOT_UBI:=$(TOPDIR)/uboot-static/uboot-mpc85xx-TURRIS1-ubifs

include $(INCLUDE_DIR)/package.mk

define Package/uboot-turris
  DEPENDS:=@TARGET_mpc85xx_p2020_nand_TURRISNAND
  TITLE:=uboot-turris
endef

define Build/Prepare
endef

define Build/Compile
endef
	
define Package/uboot-turris/postinst
#!/bin/sh
if [ -z "$$IPKG_INSTROOT" ]; then
    	fstype=$$(sed -nr 's/.*rootfstype=([a-z0-9]+).*/\1/p' /proc/cmdline)
		
	mtd -e /dev/mtd5 write /boot/uboot/uboot-$${fstype}-$(PKG_VERSION) /dev/mtd5
	ret=$$?
	if [ $$ret -ne 0 ]; then
	    echo "mtd -e /dev/mtd5 write /boot/uboot/uboot-$${fstype}-$(PKG_VERSION) /dev/mtd5 && \\"  > /etc/uci-defaults/10-flash_uboot
	    echo "touch /lib/uboot/uboot-$(PKG_VERSION).installed && \\" >> /etc/uci-defaults/10-flash_uboot
	    echo "reboot" >> /etc/uci-defaults/10-flash_uboot
	else
	    touch /lib/uboot/uboot-$(PKG_VERSION).installed
	fi
else
	rm $${IPKG_INSTROOT}/boot/uboot/uboot-$(PKG_VERSION)
	touch $${IPKG_INSTROOT}/lib/uboot/uboot-$(PKG_VERSION).installed
fi
endef

define Package/uboot-turris/install
	$(INSTALL_DIR) $(1)/boot/uboot/
	$(CP) $(UBOOT_JFFS2) $(1)/boot/uboot/uboot-jffs2-$(PKG_VERSION)
	$(CP) $(UBOOT_UBI) $(1)/boot/uboot/uboot-ubifs-$(PKG_VERSION)

	$(INSTALL_DIR) $(1)/lib/uboot/
endef

$(eval $(call BuildPackage,uboot-turris))
