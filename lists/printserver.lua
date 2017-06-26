if features and features.provides then
	if model and model:match("[Oo]mnia") then -- These are supported only on Omnia
		Install "luci-app-cups" "cups" "cups-client" "hplip" "openprinting-cups-filters" "gutenprint-cups" "ghostscript" "ghostscript-fonts-std" "ghostscript-gnu-gs-fonts-other" { ignore = { 'missing' } }
	end
	Install "luci-app-p910nd" "luci-i18n-p910nd-cs" "luci-i18n-p910nd-en" "kmod-usb2" "usbutils" "kmod-usb-printer" { ignore = { 'missing' } }
end
