define Profile/Turris-Lite
  NAME:=Turris Lite
  PACKAGES:= \
	kmod-mmc kmod-mvsdio kmod-usb3 kmod-usb-storage \
	kmod-i2c-core kmod-i2c-mv64xxx \
	kmod-thermal-armada
endef

define Profile/Turris-Lite/Description
 Package set compatible with the Armada 385 reference design board (RD-88F6820-AP).
endef

$(eval $(call Profile,Turris-Lite))
