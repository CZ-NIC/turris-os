#
# Copyright (C) 2013-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=firewall
PKG_VERSION:=2018-06-13
PKG_RELEASE:=$(PKG_SOURCE_VERSION)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://git.openwrt.org/project/firewall3.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=30463d08056db8f03d17c0569581aef96418c38d
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MAINTAINER:=Stepan Henek <stepan.henek@nic.cz>
PKG_LICENSE:=ISC

PKG_CONFIG_DEPENDS := CONFIG_IPV6

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/firewall
  SECTION:=net
  CATEGORY:=Base system
  TITLE:=OpenWrt C Firewall
  DEPENDS:=+libubox +libubus +libuci +libip4tc +IPV6:libip6tc +libxtables +kmod-ipt-core +kmod-ipt-conntrack +kmod-ipt-nat
endef

define Package/firewall/description
 This package provides a config-compatible C implementation of the UCI firewall.
 It is a modified version of the original project (git://nbd.name/firewall3.git) enriched with custom logging rules.
endef

define Package/firewall/conffiles
/etc/config/firewall
/etc/firewall.user
endef

TARGET_CFLAGS += -ffunction-sections -fdata-sections
TARGET_LDFLAGS += -Wl,--gc-sections
CMAKE_OPTIONS += $(if $(CONFIG_IPV6),,-DDISABLE_IPV6=1)

define Package/firewall/install
	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/firewall3 $(1)/sbin/fw3
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/firewall.init $(1)/etc/init.d/firewall
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_DATA) ./files/firewall.hotplug $(1)/etc/hotplug.d/iface/20-firewall
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_DATA) ./files/firewall.config $(1)/etc/config/firewall
	$(INSTALL_DIR) $(1)/etc/
	$(INSTALL_DATA) ./files/firewall.user $(1)/etc/firewall.user
	$(INSTALL_DIR) $(1)/etc/firewall.d/with_reload
	$(INSTALL_BIN) ./files/firewall.includedir $(1)/etc/firewall.d/with_reload/firewall.include.sh
	sed -i -e 's/BASEDIR=.*/BASEDIR=\/etc\/firewall.d\/with_reload\//' $(1)/etc/firewall.d/with_reload/firewall.include.sh
	$(INSTALL_DIR) $(1)/etc/firewall.d/without_reload
	$(INSTALL_BIN) ./files/firewall.includedir $(1)/etc/firewall.d/without_reload/firewall.include.sh
	sed -i -e 's/BASEDIR=.*/BASEDIR=\/etc\/firewall.d\/without_reload\//' $(1)/etc/firewall.d/without_reload/firewall.include.sh
endef

define Package/firewall/postinst
#!/bin/sh
# check if we are on real system
if [ -z "$${IPKG_INSTROOT}" ]; then
	# fill in log_limit_burst
	for index in $$(uci show firewall | grep log_prefix | sed -e 's/^firewall.@zone\[//' -e 's/\].*//'); do
		 uci -q get firewall.@zone["$${index}"].log_limit_burst
		 res=$$?
		 if [ $${res} = 1 ]; then
			echo -n 'Updating firewall... ' &&
			uci set firewall.@zone["$${index}"].log_limit_burst=500 &&
			uci commit firewall &&
			echo 'OK'
		 fi
	done
	need_with_reload=true
	need_without_reload=true
	idx=0
	while [ "$$(uci -q get firewall.@include[$$idx] || echo none)" = "include" ] ; do
		path="$$(uci -q get firewall.@include[$$idx].path)"
		if [ "$$path" = "/etc/firewall.d/with_reload/firewall.include.sh" ] ; then
			need_with_reload=false
		elif [ "$$path" = "/etc/firewall.d/without_reload/firewall.include.sh" ] ; then
			need_without_reload=false
		fi
		idx=$$((idx + 1))
	done
	if $$need_with_reload ; then
		name=$$(uci add firewall include)
		uci set firewall.$$name.path=/etc/firewall.d/with_reload/firewall.include.sh
		uci set firewall.$$name.reload=1
	fi
	if $$need_without_reload ; then
		name=$$(uci add firewall include)
		uci set firewall.$$name.path=/etc/firewall.d/without_reload/firewall.include.sh
		uci set firewall.$$name.reload=0
	fi
	if $$need_with_reload || $$need_without_reload ; then
		uci commit firewall
	fi
	echo -n 'Reloading firewall... ' &&
	/etc/init.d/firewall reload 1>/dev/null 2>&1 &&
	echo 'OK'
fi
exit 0
endef

$(eval $(call BuildPackage,firewall))
