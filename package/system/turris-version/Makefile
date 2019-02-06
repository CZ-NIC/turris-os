#
## Copyright (C) 2014-2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-version
PKG_VERSION:=3.11.3

PKG_MAINTAINER:=CZ.NIC <packaging@nic.cz>

include $(INCLUDE_DIR)/package.mk

define Package/turris-version
	TITLE:=turris-version
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/turris-version/postinst
#!/bin/sh
# Danger: spaces are not ordinary spaces, but special unicode ones
[ -n "$$IPKG_INSTROOT" ] || {
create_notification -s news " • openssh, zmq, keepalived: bezpečnostní aktualizace
 • tvheadend, mpc, unbound, youtube-dl, czmq a další balíčky: aktualizace
 • kernel: aktualizace
 • foris: sjednocení vzhledu napříč produkty Turris
 • logread: oprava
 • foris-pakon: oprava pro Safari" " • openssh, zmq, keepalived: security updates
 • tvheadend, mpc, unbound, youtube-dl, czmq, wireguard, and various minor packages: update
 • kernel: update
 • foris: unification of themes accross all Turris products
 • logread: fix
 • foris-pakon: fix for Safari"
}
endef

define Package/turris-version/install
	$(INSTALL_DIR) $(1)/etc
	echo $(PKG_VERSION) > $(1)/etc/turris-version
endef

define Package/turris-version/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	LXC_ROOT="$$(lxc-config lxc.lxcpath)"
	[ -z "$$LXC_ROOT" -o -z "$$(lxc-ls)" ] || for name in $$(lxc-ls); do
		if df "$$LXC_ROOT/$$name/rootfs" | grep -q ^$$(df / | sed -n 's|\(/dev/[^[:blank:]]*\)[[:blank:]].*|\1|p'); then
			create_notification -s error "You are running container $$name from internal memory which is not recommended and can severally damage your router! This is not covered by warranty! Please use storage module in Foris to move it somewhere else!"
		fi
	done
} 2> /dev/null
endef

$(eval $(call BuildPackage,turris-version))
