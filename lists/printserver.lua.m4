include(utils.m4)dnl Include utility macros
dnl
_FEATURE_GUARD_

-- Tools
ifelse(_BOARD_,omnia,dnl
`Install("cups", "cups-client")
Install("openprinting-cups-filters", "gutenprint-cups", "ghostscript", "ghostscript-fonts-std", "ghostscript-gnu-gs-fonts-other")
Install("hplip")'
)dnl

-- Kernel
Install("kmod-usb2", "kmod-usb-printer")

-- Luci
Install("luci-app-p910nd"ifelse(_BOARD_,omnia,`, "luci-app-cups"'))
_LUCI_I18N_(p910nd)

_END_FEATURE_GUARD_
