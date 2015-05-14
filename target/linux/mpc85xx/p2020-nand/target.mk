FEATURES:= $(FEATURES) rtc jffs2_nand nand ubifs 
BOARDNAME:=P2020-NAND

define Target/Description
	Build firmware images for generic MPC85xx P2020 based boards with NAND flash memory.
endef

