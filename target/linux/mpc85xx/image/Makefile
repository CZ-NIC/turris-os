#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk
#JFFS2_BLOCKSIZE = 64k 128k

define imgname
$(BIN_DIR)/$(IMG_PREFIX)-$(2)-$(patsubst jffs2-%,jffs2,$(patsubst squashfs-%,squashfs,$(1)))
endef

define sysupname
$(call imgname,$(1),$(2))-sysupgrade.bin
endef

define factoryname
$(call imgname,$(1),$(2))-factory.bin
endef

zImage:=$(BIN_DIR)/$(IMG_PREFIX)-zImage

DTS_TARGETS = mpc8548cds_32b p1010rdb tl-wdr4900-v1 p1020rdb p2020rdb turris-nor turris-nand
BOOT_IMAGES:=zImage cuImage.tl-wdr4900-v1

define Image/Prepare
	$(foreach image,$(BOOT_IMAGES),
		cp $(LINUX_DIR)/arch/powerpc/boot/$(image) $(KDIR)/$(image)
	)
endef

define Image/BuildKernel
	[ -d $(BIN_DIR) ] || mkdir -p $(BIN_DIR);
	cp $(KDIR)/zImage $(zImage); 
endef

define Image/makeDTS
	$(LINUX_DIR)/scripts/dtc/dtc -I dts -O dtb $(LINUX_DIR)/arch/powerpc/boot/dts/$(1).dts -o $(BIN_DIR)/$(IMG_PREFIX)-$(1).fdt; 
endef

define Image/Build/TPLINK
	-$(STAGING_DIR_HOST)/bin/mktplinkfw \
		-H $(4) -W $(5) -F $(6) -N OpenWrt -V $(REVISION) $(7) \
		-k $(KDIR)/$(3) \
		-r $(KDIR)/root.$(1) \
		-o $(call factoryname,$(1),$(2))
	-$(STAGING_DIR_HOST)/bin/mktplinkfw \
		-H $(4) -W $(5) -F $(6) -N OpenWrt -V $(REVISION) $(7) -s \
		-k $(KDIR)/$(3) \
		-r $(KDIR)/root.$(1) \
		-o $(call sysupname,$(1),$(2))
endef

define Image/Build/Profile/TLWDR4900
	$(call Image/makeDTS,tl-wdr4900-v1)
	$(call Image/Build/TPLINK,$(1),tl-wdr4900-v1,cuImage.tl-wdr4900-v1,0x49000001,1,16Mppc)
endef

#define Image/Build/Profile/Default
#	$(call Image/Build/Profile/TLWDR4900,$(1))
#	$(call Image/Build/Profile/Turris,$(1))
#endef

define Image/Build/Profile/TURRISNOR
	echo "Building for Turris NOR!!!!!!!!!!!!!!!"
	$(call Image/makeDTS,turris-nor)

	dd if=$(BIN_DIR)/$(IMG_PREFIX)-turris-nor.fdt bs=128k conv=sync > $(BIN_DIR)/$(IMG_PREFIX)-turris-nor.bin
	$(SCRIPT_DIR)/check_filesize $(BIN_DIR)/$(IMG_PREFIX)-turris-nor.bin 0x20000
	$(SCRIPT_DIR)/pad_with_ff $(BIN_DIR)/$(IMG_PREFIX)-turris-nor.bin 0x20000

	dd if=$(KDIR)/zImage bs=128k conv=sync >> $(BIN_DIR)/$(IMG_PREFIX)-turris-nor.bin
	$(SCRIPT_DIR)/check_filesize $(BIN_DIR)/$(IMG_PREFIX)-turris-nor.bin 0x1C0000
	$(SCRIPT_DIR)/pad_with_ff $(BIN_DIR)/$(IMG_PREFIX)-turris-nor.bin 0x1C0000

	dd if=$(KDIR)/root.$(1) bs=128k conv=sync >> $(BIN_DIR)/$(IMG_PREFIX)-turris-nor.bin
	$(SCRIPT_DIR)/check_filesize $(BIN_DIR)/$(IMG_PREFIX)-turris-nor.bin 0x00340000
	$(SCRIPT_DIR)/pad_with_ff $(BIN_DIR)/$(IMG_PREFIX)-turris-nor.bin 0x00340000
	
	dd if=$(TOPDIR)/bin-nand/mpc85xx/medkit/medkit.squashfs bs=128k conv=sync >> $(BIN_DIR)/$(IMG_PREFIX)-turris-nor.bin
	$(SCRIPT_DIR)/check_filesize $(BIN_DIR)/$(IMG_PREFIX)-turris-nor.bin 0xE40000

	# Build NOR image with uboot
	dd if=$(BIN_DIR)/$(IMG_PREFIX)-turris-nor.bin of=$(BIN_DIR)/$(IMG_PREFIX)-turris-nor-uboot.bin bs=128k
	$(SCRIPT_DIR)/pad_with_ff $(BIN_DIR)/$(IMG_PREFIX)-turris-nor-uboot.bin 0x00f80000
	#dd if=$(BIN_DIR)/uboot-mpc85xx/uboot-mpc85xx-TURRIS1 bs=128k >> $(BIN_DIR)/$(IMG_PREFIX)-turris-nor-uboot.bin  
	dd if=$(TOPDIR)/uboot-static/uboot-mpc85xx-TURRIS1 bs=128k >> $(BIN_DIR)/$(IMG_PREFIX)-turris-nor-uboot.bin

	echo "Creating bootable SDCARD image."
	if [ -d $(TOPDIR)/bin-sdcard ]; then rm -rf $(TOPDIR)/bin-sdcard; fi
	mkdir $(TOPDIR)/bin-sdcard	

	# cp $(BIN_DIR)/uboot-mpc85xx/uboot-mpc85xx-TURRIS1_SDCARD $(TOPDIR)/bin-sdcard/sdcard.img
	cp $(TOPDIR)/uboot-static/uboot-mpc85xx-TURRIS1_SDCARD $(TOPDIR)/bin-sdcard/sdcard.img
	$(SCRIPT_DIR)/check_filesize $(TOPDIR)/bin-sdcard/sdcard.img 1M
	$(SCRIPT_DIR)/pad_with_ff $(TOPDIR)/bin-sdcard/sdcard.img 1M
	cat $(BIN_DIR)/$(IMG_PREFIX)-turris-nor-uboot.bin >> $(TOPDIR)/bin-sdcard/sdcard.img

endef

define Image/Build/Profile/TURRISNAND
	echo "Building for Turris NAND!!!!!!!!!!!!!!!"
	$(call Image/makeDTS,turris-nand)

	dd if=$(BIN_DIR)/$(IMG_PREFIX)-turris-nand.fdt bs=128k conv=sync > $(BIN_DIR)/$(IMG_PREFIX)-turris-nand.bin
	truncate -s 2M $(BIN_DIR)/$(IMG_PREFIX)-turris-nand.bin 

	dd if=$(KDIR)/zImage bs=128k conv=sync >> $(BIN_DIR)/$(IMG_PREFIX)-turris-nand.bin
	truncate -s 7M $(BIN_DIR)/$(IMG_PREFIX)-turris-nand.bin

	dd if=$(KDIR)/root.$(1) bs=128k conv=sync >> $(BIN_DIR)/$(IMG_PREFIX)-turris-nand.bin

	if [ -d $(BIN_DIR)/medkit ]; then rm -rf $(BIN_DIR)/medkit; fi
	mkdir $(BIN_DIR)/medkit
	gunzip -c $(BIN_DIR)/openwrt-mpc85xx-p2020-nand-TURRISNAND-rootfs.tar.gz > $(BIN_DIR)/openwrt-mpc85xx-p2020-nand-rootfs.tar
	tar cf $(BIN_DIR)/medkit/medkit.tar -C $(BIN_DIR) $(IMG_PREFIX)-turris-nand.fdt $(IMG_PREFIX)-zImage openwrt-mpc85xx-p2020-nand-rootfs.tar
	xz -9 $(BIN_DIR)/medkit/medkit.tar

	$(STAGING_DIR_HOST)/bin/mksquashfs4 $(BIN_DIR)/medkit/medkit.tar.xz $(BIN_DIR)/medkit/medkit.squashfs \
		-nopad -noappend -root-owned -comp $(SQUASHFSCOMP) -b 128k -processors $(if $(CONFIG_PKG_BUILD_JOBS),$(CONFIG_PKG_BUILD_JOBS),1)

endef


define Image/Build/Profile/P2020RDBPCA
	$(call Image/makeDTS,p2020rdb)
	echo "P2020RDBPCA build"
endef

define Image/Build/ext2
	cp $(KDIR)/root.$(1) $(BIN_DIR)/$(IMG_PREFIX)-ext2.img
endef

define Image/Build/squashfs
	$(call prepare_generic_squashfs,$(KDIR)/root.squashfs)
	cp $(KDIR)/root.squashfs $(BIN_DIR)/$(IMG_PREFIX)-root.squashfs
endef

define Image/Build/jffs2-64k
	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/$(IMG_PREFIX)-$(1).img bs=64k conv=sync
endef

define Image/Build/jffs2-128k
	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/$(IMG_PREFIX)-$(1).img bs=128k conv=sync
endef

define Image/Build/jffs2-nand-2048-128k
        dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/$(IMG_PREFIX)-$(1).img bs=128k conv=sync
endef


#PROFILE ?= Default

define Image/Build
	$(call Image/Build/$(1),$(1))
	$(call Image/Build/Profile/$(PROFILE),$(1))
endef

$(eval $(call BuildImage))
