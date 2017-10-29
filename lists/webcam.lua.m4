include(utils.m4)dnl Include utility macros
_FEATURE_GUARD_

Install("kmod-video-uvc", { priority = 40 })
Install("fswebcam", "motion", "ffmpeg", { priority = 40 })

_END_FEATURE_GUARD_
