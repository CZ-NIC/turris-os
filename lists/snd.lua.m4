include(utils.m4)dnl Include utility macros
_FEATURE_GUARD_

Install("kmod-sound-core", "kmod-usb-audio", { priority = 40 })
Install("mpd-mini", "mpc", { priority = 40 })
Install("pulseaudio-daemon", "pulseaudio-tools", "pulseaudio-profiles", { priority = 40 })

_END_FEATURE_GUARD_
