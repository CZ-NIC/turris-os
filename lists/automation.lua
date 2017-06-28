if features and features.provides then
	Install "domoticz" "home-assistant-turris-gadgets" "kmod-usb-serial-ftdi" { ignore = { 'missing' } }
end
