if features and features.provides then
	Install "kmod-video-uvc" "fswebcam" "motion" "ffmpeg" { ignore = { 'missing' } }
end
