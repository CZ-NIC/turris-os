include(utils.m4)dnl Include utility macros
dnl
_FEATURE_GUARD_

-- Tools
Install "cups" "cups-client"
Install "openprinting-cups-filters" "gutenprint-cups" "ghostscript" "ghostscript-fonts-std" "ghostscript-gnu-gs-fonts-other"
Install "usbutils"

Install "hplip"

-- Kernel
Install "kmod-usb2" "kmod-usb-printer"

-- Luci
Install "luci-app-p910nd" "luci-app-cups"
_LUCI_I18N_(p910nd)

_END_FEATURE_GUARD_
