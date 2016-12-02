if features and features.provides then
	Install "luci-app-p910nd" "luci-i18n-p910nd-cs" "luci-i18n-p910nd-en" "kmod-usb2" "usbutils" "kmod-usb-printer" "cups" "cups-client" "hplip" "openprinting-cups-filters" "gutenprint-cups" "ghostscript" "ghostscript-fonts-std" "ghostscript-gnu-gs-fonts-other" { ignore = { 'missing' } }
end
