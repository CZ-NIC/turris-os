include(utils.m4)dnl Include utility macros
dnl
_FEATURE_GUARD_

Install("domoticz", "home-assistant-turris-gadgets", "kmod-usb-serial-ftdi", { ignore = { 'missing' } })

_END_FEATURE_GUARD_
