include(utils.m4)dnl Include utility macros
dnl
_FEATURE_GUARD_

Install "kmod-veth"
Install "lxc" foreach(PKG,`"lxc-PKG" ',attach,auto,console,create,info,ls,monitor,monitord,snapshot,start,stop)
Install "luci-app-lxc"
Install "gnupg" "gnupg-utils" "tar"

_END_FEATURE_GUARD_
