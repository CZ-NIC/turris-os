include(utils.m4)dnl Include utility macros
_FEATURE_GUARD_

-- On Turris 1.x there is not enough space to install some of following packages
-- so we are just skipping them.

-- Tools
if model and not model:match("^[Tt]urris$") then
	Install("cups", "cups-client", { priority = 40 })
	Install("openprinting-cups-filters", "gutenprint-cups", "ghostscript", "ghostscript-fonts-std", "ghostscript-gnu-gs-fonts-other", { priority = 40 })
	Install("hplip", { priority = 40 })
end

-- Kernel
Install("kmod-usb2", "kmod-usb-printer", { priority = 40 })

-- Luci
Install("luci-app-p910nd", { priority = 40 })
if model and not model:match("^[Tt]urris$") then
	Install("luci-app-cups", { priority = 40 })
end
_LUCI_I18N_(p910nd)

_END_FEATURE_GUARD_
