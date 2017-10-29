dnl This is magic generating Repository command
dnl We expect this to be include in base.lua just after utils.m4
divert(-1)

# This is definition of subrepositories
# TODO generate this dynamically from feed.conf.default
pushdef(`SUBDIRS',``subdirs = {"base", "turrispackages", "php", "hardware", "lucics", "packages", "routing", "management", "telephony", "printing"}'')dnl

divert(0)dnl
dnl
dnl Basic turris repository
Repository("turris", "https://api.turris.cz/openwrt-repo/_BOARD_`'ifdef(`_BRANCH_',-_BRANCH_)/packages", {
	SUBDIRS
})
dnl
dnl Fallback turris repository for not complete branches
dnl In testing branches we are compiling just a minimal set of packages to allow
dnl updater to use all packages we are adding nightly as fallback reposutory.
ifdef(`_BRANCH_FALLBACK_',
`Repository("turris-fallback", "https://api.turris.cz/openwrt-repo/_BOARD_-_BRANCH_FALLBACK_/packages", {
	SUBDIRS,
	priority = 40,
	ignore = {"missing"}
})
')
dnl
divert(-1)

# Now just clean up after our self
popdef(`SUBDIRS')

divert(0)dnl
