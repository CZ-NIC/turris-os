# 
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=kernel

PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/packages
SCAN_DEPS=modules/*.mk $(TOPDIR)/target/linux/*/modules.mk

PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=
PKG_VERSION:=8

include $(INCLUDE_DIR)/package.mk

STAMP_BUILT:=$(STAMP_BUILT)_$(firstword $(shell $(SCRIPT_DIR)/kconfig.pl $(LINUX_DIR)/.config | md5sum))

ifeq ($(DUMP),)
  -include $(LINUX_DIR)/.config
endif

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
	$(LINUX_DIR)/scripts/dtc/dtc -I dts -O dtb $(LINUX_DIR)/arch/powerpc/boot/dts/turris-nand-bch.dts -o $(PKG_BUILD_DIR)/fdt-bch
	$(LINUX_DIR)/scripts/dtc/dtc -I dts -O dtb $(LINUX_DIR)/arch/powerpc/boot/dts/turris-nand-hw.dts -o $(PKG_BUILD_DIR)/fdt-hw
endef

define KernelPackage/depends
endef

CONFIG_PACKAGE_kernel=y
define Package/kernel
  SECTION:=sys
  CATEGORY:=Kernel
  DEFAULT:=y
  TITLE:=Kernel package
  VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC)
  URL:=http://www.kernel.org/
  DEPENDS:=+create_notification +uboot-turris
endef

define Package/kernel/install
	$(INSTALL_DIR) $(1)/boot
	$(INSTALL_DIR) $(1)/etc/uci-defaults

	$(CP) ./files/01_fix_pcie_paths			$(1)/etc/uci-defaults/01_fix_pcie_paths

	$(CP) $(LINUX_DIR)/arch/powerpc/boot/zImage	$(1)/boot/zImage-$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC)
	$(CP) $(PKG_BUILD_DIR)/fdt-bch 			$(1)/boot/fdt-bch-$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC)
	$(CP) $(PKG_BUILD_DIR)/fdt-hw                   $(1)/boot/fdt-hw-$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC)
	ln -sf zImage-$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC) $(1)/boot/zImage
	ln -sf fdt-bch-$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC) $(1)/boot/fdt
endef

define Package/kernel/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
    fstype=$$(sed -nr 's/.*rootfstype=([a-z0-9]+).*/\1/p' /proc/cmdline)
    case $$fstype in
    "jffs2")
    	echo "JFFS2 rootfstype found"
	echo "Erasing and flashing FDT partition."
	flash_erase /dev/mtd6 0 0 && nandwrite -p /dev/mtd6 /boot/fdt-hw-$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC)

	echo "Erasing and flashing kernel partition."
	if [ -f /lib/uboot/uboot-1.installed ]; then
		flash_erase /dev/mtd7 0 0 && nandwrite -p /dev/mtd7 /boot/zImage-$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC)
	else
		echo "[ -f /lib/uboot/uboot-1.installed ] && \\" > /etc/uci-defaults/11-flash_kernel
	    	echo "flash_erase /dev/mtd7 0 0 && nandwrite -p /dev/mtd7 /boot/zImage-$(LINUX_VERSION)-$(LINUX_RELEASE)-$(LINUX_VERMAGIC) && \\" >> /etc/uci-defaults/11-flash_kernel
		echo "reboot" >> /etc/uci-defaults/11-flash_kernel
	fi
	;;
    "ubifs")
    	echo "UBIFS rootfstype found"
        ;;
    esac

    create_notification -s restart "Jádro systému bylo aktualizováno na verzi $(VERSION). Prosím restartujte své zařízení."
fi
endef

define Package/kernel/extra_provides
	sed -e 's,.*/,,' $(LINUX_DIR)/modules.builtin;
endef

$(eval $(if $(DUMP),,$(call BuildPackage,kernel)))

include $(sort $(wildcard ./modules/*.mk))
-include $(TOPDIR)/target/linux/*/modules.mk
