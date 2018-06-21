include(utils.m4)dnl Include utility macros
_FEATURE_GUARD_

Install("domoticz", "home-assistant-turris-gadgets", "kmod-usb-serial-ftdi", { ignore = { 'missing' }, priority = 40 })

_END_FEATURE_GUARD_
