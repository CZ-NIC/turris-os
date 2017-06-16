include(utils.m4)dnl Include utility macros
dnl
Install "kmod-veth"
Install "lxc" foreach(PKG,`"lxc-PKG" ',attach,auto,create,info,ls,monitor,monitord,snapshot,start,stop)
Install "luci-app-lxc"
Install "gnupg" "gnupg-utils" "tar"
